// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/***
    BEGIN LICENSE

    Copyright (C) 2013-2014 Akshay Shekher<voldyman666@gmail.com>
    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU Lesser General Public License version 3, as published
    by the Free Software Foundation.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranties of
    MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
    PURPOSE.  See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program.  If not, see <http://www.gnu.org/licenses/>

    END LICENSE
***/

using Gtk;
using Granite.Widgets;

namespace Podder {
    public class PodBox : EventBox {
        public const string STYLESHEET  =
        ".podbox {
            background-color: #ffffff;
            border-radius: 2px;
            border-width: 5px;
            border-color: #f2f2f2;
            margin: 20px;
        }
        .podbox:hover {
            background-color: #000;
        }";
        PodcastData data;
        Grid layout_grid;

        public PodBox (PodcastData pod_data) {
            data = pod_data;
            layout_grid = new Gtk.Grid ();
            layout_grid.hexpand =false;
            setup_ui ();
            add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
            this.button_press_event.connect (() => {
                print ("Button Pressed");
                var info_box = new Gtk.Box (Orientation.HORIZONTAL, 5);
                info_box.pack_start (new Button.with_label ("Play"));
                info_box.pack_start (new Button.with_label ("delete"));
                info_box.pack_start (new Button.with_label ("info"));
                layout_grid.attach (info_box, 0, 2, 3, 1);
                info_box.show_all ();
                return false;
            });
        }
        public void setup_ui () {
            Granite.Widgets.Utils.set_theming (this, STYLESHEET, "podbox", Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            var image = new Gtk.Image.from_stock (Gtk.Stock.MISSING_IMAGE, Gtk.IconSize.LARGE_TOOLBAR);

            var title = new Gtk.Label ("<b>" + data.title + "</b>");
            title.set_use_markup (true);
            title.set_line_wrap (true);

            var description = new Gtk.Label (data.description);
            description.set_use_markup (true);
            description.set_line_wrap (true);

            layout_grid.attach (image, 0, 0, 2, 2);
            layout_grid.attach (title, 2, 0, 1, 1);
            layout_grid.attach (description, 2, 1, 1, 1);
            add (layout_grid);
            show_all ();
        }
    }
}
