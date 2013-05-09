/***
    Copyright (C) 2013-2014 Podder Developers

    This program or library is free software; you can redistribute it
    and/or modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 3 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General
    Public License along with this library; if not, write to the
    Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301 USA.

    Authored By: Akshay Shekher <voldyman666@gmail.com>
    Original Author: KJ Lawrence <kjtehprogrammer@gmail.com>
***/

namespace Podder {
    public class WindowToolbar : Podder.Toolbar {
        public Podder.AppWindow Window { get; set; }

        Gtk.Label title_label;
        public new string title {
            get { return title_label.label; }
            set {
                // ToDO: Limit the value to a certain amount of characters
                // Preferrably truncating from the beginning (so the loaded
                // file is viewable in the title)
                if (value != null && value != "Podder")
                    title_label.label = "Podder - " + value;
                else
                    title_label.label = "Podder";
            }
        }

        const int HEIGHT = 32;

        /**
         * Intializes the main window's toolbar and
         * establishes all of the events for the buttons
         * @param window Main Application Window
         */
        public WindowToolbar (Podder.AppWindow window) {
            base ("app-toolbar", false, Gtk.IconSize.LARGE_TOOLBAR, 3);
            Window = window;

            set_events (Gdk.EventMask.ALL_EVENTS_MASK);
            event.connect (toolbar_clicked);

            var close = new Gtk.ToolButton (new Gtk.Image.from_file ("/usr/share/themes/elementary/metacity-1/close.svg"), "Close");
            close.height_request = HEIGHT;
            close.width_request = HEIGHT;
            close.clicked.connect (() => Window.destroy());

            var maximize = new Gtk.ToolButton (new Gtk.Image.from_file ("/usr/share/themes/elementary/metacity-1/maximize.svg"), "Close");
            maximize.height_request = HEIGHT;
            maximize.width_request = HEIGHT;
            maximize.clicked.connect (() => {
                if (!Window.maximized) {
                    Window.maximize ();
                    Window.maximized = true;
                } else {
                    Window.unmaximize();
                    Window.maximized = false;
                }
            });

            // Build up the title label
            title_label = new Gtk.Label ("");
            title_label.get_style_context ().add_class ("app-title");
            title_label.override_font (Pango.FontDescription.from_string ("bold"));

            var title_container = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            title_container.hexpand = true;
            title_container.vexpand = true;
            title_container.halign = Gtk.Align.CENTER;
            title_container.add (title_label);

            add_left (close);
            add_left (create_separator(HEIGHT));

            add_center (title_container);

            add_right (create_separator(HEIGHT));
            add_right (maximize);
        }

        /**
         * Updates the opened images icon with a count badge
         * @param count Count of images opened
         */
        public void update_open_count (int count) {

        }

        private bool toolbar_clicked (Gtk.Widget widget, Gdk.Event event) {
            if (event.type == Gdk.EventType.2BUTTON_PRESS && event.button.button == 1) {
                if (!Window.maximized) {
                    Window.maximize ();
                    Window.maximized = true;
                } else {
                    Window.unmaximize ();
                    Window.maximized = false;
                }
            }
            return false;
        }
    }
}
