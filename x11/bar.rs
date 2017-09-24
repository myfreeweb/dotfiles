#!/usr/bin/env run-cargo-script
//! ```cargo
//! [dependencies]
//! unixbar = { path = "../../src/github.com/myfreeweb/unixbar" }
//! systemstat = "0"
//! ```

#[macro_use] extern crate unixbar;
extern crate systemstat;
use unixbar::*;
use systemstat::{System, Platform};


fn load_color(percent: f32) -> String {
    match percent {
        x if x >= 80.0              => "#d24b58",
        x if x >= 60.0 && x < 80.0  => "#daa345",
        _                           => "#94aa82",
    }.to_owned()
}

fn main() {
    UnixBar::new(I3BarFormatter::new())

        .add(Text::new(bfmt![right]))

        .add(Periodic::new(
             Duration::from_secs(2),
             || match System::new().memory() {
                 Ok(mem) => {
                     let percent = (1.0 - mem.free.as_usize() as f32/mem.total.as_usize() as f32) * 100.0;
                     bfmt![fg[load_color(percent)] fmt[" {:02.0}% \u{f1c0} ", percent]]
                 },
                 Err(_) => bfmt![fg["#bb1155"] text["error"]],
             }))

        .add(Delayed::new(
             Duration::from_secs(2),
             || System::new().cpu_load_aggregate().unwrap(),
             |res| match res {
                 Ok(cpu) => {
                     let percent = (1.0 - cpu.idle) * 100.0;
                     bfmt![fg[load_color(percent)] fmt[" {:02.0}% \u{f0e4} ", percent]]
                 },
                 Err(_) => bfmt![fg["#bb1155"] text["error"]],
             }))

        .add(Periodic::new(
             Duration::from_secs(30),
             || match System::new().battery_life() {
                 Ok(battery) => {
                     let percent = (battery.remaining_capacity * 100.0) as u8;
                     let color = match percent {
                         x if x >= 20  => "#94aa82",
                         20...40       => "#daa345",
                         _             => "#d24b58",
                     };
                     let icon = match percent {
                         x if x >= 80  => "\u{f240}",
                         60...80       => "\u{f241}",
                         40...60       => "\u{f242}",
                         20...40       => "\u{f243}",
                         _             => "\u{f244}",
                     };
                     bfmt![fg[color] fmt[" {:02}% {} ", percent, icon]]
                 },
                 Err(_) => bfmt![text[""]],
             }))

        .add(Volume::new(default_volume(),
             |volume| {
                 let vol = (volume.volume * 100.0) as i32;
                 let icon = match vol {
                     x if x >= 50  => "\u{f028}",
                     1...50        => "\u{f027}",
                     _             => "\u{f026}",
                 };
                 bfmt![fg[load_color(vol as f32)] fmt[" {} {} ", vol, icon]]
             },
        ))

        .add(Xkb::new(|id| {
            let layout = match id {
                0 => "EN",
                1 => "RU",
                _ => "??",
            };
            bfmt![ fg["#bebebe"] fmt[" {} \u{f11c} ", layout] ]
        }))

        .add(Wrap::new(
             |f| bfmt![fg["#ececec"] f],
             DateTime::new(" %a %b %e %H:%M ")))

        //.add(Text::new(bfmt![ fg["#bebebe"] click[MouseButton::Left => format!("xautolock -locknow")] text[" \u{f023} "] ]))

        .run();
}
