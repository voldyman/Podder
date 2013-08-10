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

    public class ContentView : Granite.Widgets.ThinPaned {
        public enum Category {
            CHANNELS,
            DOWNLOADS
        }

        private SourceList sidebar;
        private Notebook page_switcher;

        private SourceList.ExpandableItem channels_category;
        private SourceList.ExpandableItem downloads_category;

        public ContentView () {
            sidebar = new Granite.Widgets.SourceList ();

            page_switcher = new Gtk.Notebook ();
            page_switcher.show_tabs = false;
            page_switcher.show_border = false;
            page_switcher.expand = true;

            sidebar.item_selected.connect ((item) => {
                var sidebar_item = item as SourceListItem;
                assert (sidebar_item != null);
                page_switcher.set_current_page (sidebar_item.page_num);
            });

            // Main sidebar categories
            channels_category = new Granite.Widgets.SourceList.ExpandableItem ("Channels");
            downloads_category = new Granite.Widgets.SourceList.ExpandableItem ("Downloads");

            var welcome_item = new SourceListItem ("Welcome");
            welcome_item.icon = null;
            welcome_item.page_num = page_switcher.append_page (create_welcome_screen (), null);

            PodcastData data = PodcastData () {
                title = "Nerdist",
                description = "doodle",
                url = "d",
                logo_url = "a"
            };
            var box = new Gtk.Box (Orientation.VERTICAL, 5);
            box.pack_start (new PodBox (data), false, false);
            box.pack_start (new PodBox (data), false, false);
            box.pack_start (new PodBox (data), false, false);
            box.pack_start (new PodBox (data), false, false);
            add_item ("Nerdist", new PodList (), Category.CHANNELS);
            // Add and expand categories
            sidebar.root.add (welcome_item);
            sidebar.root.add (channels_category);
            sidebar.root.add (downloads_category);
            sidebar.root.expand_all ();

            base.pack1 (sidebar, true, false);
            base.pack2 (page_switcher, true, false);
            base.expand = true;
        }

        public void add_item (string title, Widget page, Category cat, bool selected = false) {
            var item = new SourceListItem (title);
            switch (cat) {
                case Category.CHANNELS:
                    channels_category.add (item);
                    break;
                case Category.DOWNLOADS:
                    downloads_category.add (item);
                    break;
                default:
                    return;
            }
            item.page_num = page_switcher.append_page (page, null);

            if (selected) {
                sidebar.selected = item;
            }
        }

        private Granite.Widgets.Welcome create_welcome_screen () {
            var welcome = new Granite.Widgets.Welcome ("Welcome to Podder",
                                                       "Your elementary podcast solution");

            Gdk.Pixbuf? pixbuf = null;

            try {
                pixbuf = Gtk.IconTheme.get_default ().load_icon ("document-new", 48,
                                                                 Gtk.IconLookupFlags.GENERIC_FALLBACK);
            } catch (Error e) {
                warning ("Could not load icon, %s", e.message);
            }

            // Adding elements. Use the most convenient method to add an icon
            welcome.append_with_pixbuf (pixbuf, "Add", "Add a new podcast.");

            return welcome;
        }
    }
    /**
     * SourceList item. It stores the number of the corresponding page in the notebook widget.
     */
    private class SourceListItem : Granite.Widgets.SourceList.Item {
        public int page_num { get; set; default = -1; }
        private Icon? themed_icon;

        public SourceListItem (string title, string? icon = null) {
            base (title);
            editable = false;

            if (icon != null)
                themed_icon = new ThemedIcon.with_default_fallbacks (icon);

            this.icon = themed_icon;
        }
    }
}
