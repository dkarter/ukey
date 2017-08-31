#!/usr/bin/env ruby

#
# <bitbar.title>Ukey</bitbar.title>
# <bitbar.version>v0.1.4</bitbar.version>
# <bitbar.author>Dorian Karter</bitbar.author>
# <bitbar.author.github>dkarter</bitbar.author.github>
# <bitbar.desc>Displays the status of the ukey utility and allows controlling it from the menu bar</bitbar.desc>
# <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
# <bitbar.dependencies>ruby, ukey gem, python, libusb, rbenv</bitbar.dependencies>
# <bitbar.abouturl>https://doriankarter.com/</bitbar.abouturl>

module UkeyBitBar
  class << self
    def deactivate
      system("kill $(ps ax | grep '[u]key watch' | awk '{ print $1 }')")
    end

    def activate
      spawn('export PATH="$HOME/.rbenv/shims:$PATH"; ukey watch')
    end

    def active?
      @active ||= system('ps -ax | grep "[u]key watch" 2>&1 >/dev/null')
    end

    def render_line(title, params = {})
      args = params.map { |k, v| "#{k}=#{v}" }.join(' ')
      puts "#{title} | #{args}"
    end

    def render_separator
      puts '---'
    end

    def circle
      "\u25CF"
    end

    def render_status
      title = active? ? "#{circle} Active" : "#{circle} Inactive"
      color = active? ? '#6a975b' : '#e5706b'
      render_line(
        "#{title}. Click to refresh.",
        refresh: true,
        color:   color,
      )
      render_separator
    end

    def render_icon
      puts active? ? '🔐' : '🔓'
    end

    def render_deactivate
      render_line 'Deactivate', {
        bash:     $0,
        param1:   'deactivate',
        terminal: false,
        refresh: true,
      }
    end

    def render_activate
      render_line 'Activate', {
        bash:     $0,
        param1:   'activate',
        # bash: '"(echo $PATH > ~/out.txt)"',
        terminal: false,
        refresh: true,
      }
    end

    def render_status_toggle
      active? ? render_deactivate : render_activate
    end

    def render
      render_icon
      render_separator
      render_status
      render_separator
      render_status_toggle
    end
  end
end

UkeyBitBar.render
UkeyBitBar.deactivate if ARGV.include?('deactivate')
UkeyBitBar.activate if ARGV.include?('activate')
