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
using Granite;
using Granite.Services;

namespace Podder {

    public class Application : Granite.Application {
        construct {
            build_data_dir = Build.DATADIR;
            build_pkg_data_dir = Build.PKGDATADIR;
            build_release_name = Build.RELEASE_NAME;
            build_version = Build.VERSION;
            build_version_info = Build.VERSION_INFO;

            program_name = "podder";
            exec_name = "podder";

            app_years = "2013";
            app_icon = "application-default-icon";

            app_copyright = "2013";
            application_id = "org.elementaryos.podder";
            app_icon = "podder";
            app_launcher = "podder.desktop";

            main_url = "https://github.com/voldyman/podder";
            bug_url = "https://github.com/voldyman/podder";
            help_url = "https:///github.com/voldyman/podder";

            about_authors = {"Akshay Shekher<voldyman666@gmail.com>"};
            about_documenters = {"Akshay Shekher<voldyman666@gmail.com>"};
            about_artists = {"Akshay Shekher<voldyman666@gmail.com"};
            //about_translators = "";
        }

        public Window main_window;
        public Application () {
            Logger.initialize ("Podder");
            Logger.DisplayLevel = LogLevel.DEBUG;
        }

        protected override void activate () {
            main_window = new AppWindow (this);
        }
    }
    int main (string[] args)  {
        return new Podder.Application ().run (args);
    }
}
