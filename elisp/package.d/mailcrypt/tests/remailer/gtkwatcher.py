#! /usr/bin/python

import watcher
import gtk
import libglade
import time

class GtkWatcher:
    def __init__(self, watcher=None):
        xml = libglade.GladeXML('gtkwatcher.glade')
        xml.signal_connect('do_poll', self.poll)
        xml.signal_connect('do_exit', gtk.mainquit)
        self.src_clist = xml.get_widget('src_clist')
        self.dst_clist = xml.get_widget('dst_clist')
        self.srcwin = xml.get_widget('srcwin')
        self.dstwin = xml.get_widget('dstwin')
        self.src_clist.connect('select-row', self.do_src_select)
        self.dst_clist.connect('select-row', self.do_dst_select)
        self.text = xml.get_widget('text1')
        self.text.set_line_wrap(0)
        self.textwin = xml.get_widget('textwin')
        xml.get_widget('window1').set_usize(500,300)
        self.xml = xml
        self.watcher = watcher
        self.outstanding = []
        self.received = []
    def set_watcher(self, watcher=None):
        self.watcher = watcher
    def time_string(self, latency):
        hours = latency / 3600
        latency -= hours * 3600
        minutes = latency / 60
        latency -= minutes * 60
        seconds = latency
        latency = ''
        if hours:
            latency = '%dh' % hours
        if hours or minutes:
            latency = latency + '%dm' % minutes
        latency = latency + '%ds' % seconds
        return latency
    def update_text(self, text):
        self.text.freeze()
        self.text.delete_text(0,-1)
        self.text.insert_defaults(text)
        # this one causes a segfault
        #self.text.set_position(-1)
        # this one doesn't seem to do anything
        #self.text.set_point(self.text.get_length())
        # this one grabs the cursor and runs off into an infinite loop
        #self.text.set_position(self.text.get_length())
        self.text.thaw()
        # this one works, but it must be done after the text is thawed
        va = self.textwin.get_vadjustment()
        va.set_value(va.upper)
        va.value_changed()
        
    def do_src_select(self, clist, row, col, event):
        msgid = clist.get_row_data(row)
        # get the message text from the Outstanding list
        f = self.watcher.source.ids[msgid]
        file = self.watcher.source.files[f]
        text = file['data']
        self.update_text(text)
    def do_dst_select(self, clist, row, col, event):
        msgid = clist.get_row_data(row)
        # get the message text from the Received list
        f = self.watcher.dest.ids[msgid]
        file = self.watcher.dest.files[f]
        text = file['data']
        self.update_text(text)
    def poll(self, *args):
        self.watcher.poll()
        outstanding = self.watcher.outstanding()
        if outstanding != self.outstanding:
            ol = self.src_clist
            ol.freeze()
            ol.clear()
            maxrow = 0
            for i in outstanding:
                (msgid, txtime) = i
                #elapsed = self.time_string(int(time.time()) - txtime)
                sent = time.strftime("%H:%M   %d %b %Y",time.gmtime(txtime))
                row = ol.append((msgid, sent))
                ol.set_row_data(row, msgid)
                ol.set_selectable(row, 0)
                maxrow = row
            ol.thaw()
            ol.moveto(maxrow, 0, 1.0, 0.0)
        self.outstanding = outstanding

        received = self.watcher.received()
        if received != self.received:
            rl = self.dst_clist
            rl.freeze()
            rl.clear()
            maxrow = 0
            for i in received:
                (msgid, latency) = i
                row = rl.append((msgid, self.time_string(latency)))
                rl.set_row_data(row, msgid)
                rl.set_selectable(row, 0)
                maxrow = row
            rl.thaw()
            rl.moveto(maxrow, 0, 1.0, 0.0)
        self.received = received
        return 1
    

def main():
    w = watcher.Watcher('sdir', 'ddir')
    g = GtkWatcher(w)
    g.poll()
    dir_poller = gtk.timeout_add(5*1000, g.poll)
    gtk.mainloop()

if __name__ == '__main__': main()
