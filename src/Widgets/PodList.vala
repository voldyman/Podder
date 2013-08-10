// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/***
    BEGIN LICENSE

    Copyright (C) 2013 Akshay Shekher<voldyman666@gmail.com>
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

    public class PodList : Gtk.VBox {

        public PodList() {
            pack_start(create_container ("a", "asgfd"));
            pack_start(create_container ("a", "asgfd"));
            pack_start(create_container ("a", "asgfd"));
            pack_start(create_container ("a", "asgfd"));
        }

        private Grid create_container (string title, string desc) {
            var title_label = new Gtk.Label ("");
            title_label.set_markup ("<b>%s</b>".printf(title));
            var desc_label = new Gtk.Label (desc);
            var cont = new Gtk.Grid ();
            cont.attach (title_label, 0, 0, 1, 1);
            cont.attach (desc_label, 0, 1, 1, 1);

            return cont;
        }
    }
}
