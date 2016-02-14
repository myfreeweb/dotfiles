#!/usr/bin/env run-cargo-script
//! ```cargo
//! [dependencies]
//! regex = "0.1"
//! dbus = "0.3"
//! ```
extern crate dbus;
extern crate regex;

use std::{env, process, iter};
use std::borrow::Cow;
use dbus::{Connection, BusType, Message, MessageItem};

fn notify(msg: &str) {
    let c = Connection::get_private(BusType::Session).unwrap();
    let mut m = Message::new_method_call(
        "org.freedesktop.Notifications", "/org/freedesktop/Notifications",
        "org.freedesktop.Notifications", "Notify").unwrap();
    m.append_items(&[
       "mixer".to_owned().into(), // appname
       (999989999 as u32).into(), // notification to update
       "".to_owned().into(),      // icon
       format!("<span weight='normal' font='13'>{}</span>", msg).to_owned().into(), // summary (title)
       "".to_owned().into(),      // body
       MessageItem::Array(vec![], Cow::Borrowed("s")).into(),     // actions
       MessageItem::Array(vec![], Cow::Borrowed("{sv}")).into(),  // hints
       300.into()                 // timeout
    ]);
    c.send_with_reply_and_block(m, 1000).unwrap();
}

fn main() {
    let mixer_arg = env::args().skip(1).next()
        .expect("You need to provide an argument");
    let mixer_output = process::Command::new("mixer").arg("vol").arg(&mixer_arg)
        .output().expect("Mixer failed").stdout;
    let mixer_output = String::from_utf8_lossy(&mixer_output);
    let mixer_n : usize = regex::Regex::new(r"to ([0-9]+):").unwrap()
        .captures_iter(&mixer_output)
        .next().unwrap().at(1).unwrap().parse().ok().unwrap();

    notify(&format!("🔈 {}{} 🔈",
        iter::repeat("+").take(mixer_n/5).collect::<String>(),
        iter::repeat("-").take(20 - mixer_n/5).collect::<String>()));
}
