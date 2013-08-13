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
    public class AppWindow : Gtk.Window {
        private Box container;
        public Grid content;
        public StatusBar statusbar;
        public ContentView content_view;
        private Podder.WindowToolbar window_toolbar { get; private set; }

        public bool maximized { get; set; }
        public new string title {
            get { return window_toolbar.title; }
            set { window_toolbar.title = value; }
        }

        public AppWindow (Application app) {
            this.set_application (app);
            setup_ui ();
            this.title = "Podder";
            this.window_position = WindowPosition.CENTER;
            this.set_default_size (800, 550);
            this.show_all ();
        }


        public void setup_ui () {
            container = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            container.expand = true;
            window_toolbar = new Podder.WindowToolbar (this);

            content = new Gtk.Grid ();
            content.expand = true;
            content.orientation = Gtk.Orientation.VERTICAL;

            //ContentView
            content_view = new Podder.ContentView ();
            content.attach (content_view , 0, 0, 1, 1);
            content.show_all ();

            // Statusbar
            statusbar = new Granite.Widgets.StatusBar ();
            statusbar.set_text ("");
            statusbar.hexpand = true;
            statusbar.vexpand = false;

            container.pack_start (window_toolbar, false);
            container.pack_start (content);
            container.pack_end (statusbar,false);
            add (container);
        }

        public bool exit () {
            Gtk.main_quit ();
            return false;
        }

        public override void show () {
            base.show ();
            get_window ().set_decorations (Gdk.WMDecoration.BORDER);
        }
    }
}
