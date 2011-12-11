--- 
layout: post
title: New raid array with Linux and mdadm
comments: true
categories: Tech
---
I ran out of free space on my file server a few months back and have been too cheap to upgrade until recently.  I first started with four 400 <a href="http://en.wikipedia.org/wiki/Gigabyte">GB</a> drives a few years ago and setup a <a href="http://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_5">RAID 5</a> array using Linux and <a href="http://en.wikipedia.org/wiki/Mdadm">mdadm</a> giving me roughly 1.2 <a href="http://en.wikipedia.org/wiki/Terabyte">TB</a> of space.  I upgraded a disk at a time as needed until I had seven drives and about 2.6 TB of space:

``` 
Filesystem            Size  Used Avail Use% Mounted on
/dev/md0              2.6T  2.6T  2.8G 100% /mnt/sata-array
```

Having filled this up I started looking for the best way to upgrade.  The <a href="http://en.wikipedia.org/wiki/Seagate_Technology">Seagate</a> 1.5 TB drives offered the best per GB pricing however with the recent <a href="http://hardware.slashdot.org/hardware/08/11/11/2125227.shtml">bad news</a> specific to these drives I decided to stear clear of Seagate.  The next best option I could find were the 1 TB <a href="http://en.wikipedia.org/wiki/Western_Digital">Western Digital</a> Green Power drives.  The Green Power drives have a lower overall rotational speed and will spin down as allowed to save power with the added benefit of generating less heat and also noise.

After reading several threads (<a href="http://episteme.arstechnica.com/eve/forums/a/tpc/f/24609792/m/480007274931">one here</a>) regarding Bit Error Rates (BER) with drives this large and the potential for errors even with a RAID 5 array I decided to go for <a href="http://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_6">RAID 6</a> with my new array.  RAID 6 can survive 2 disk drive failuers and will theoretically protect me from the high BER these drives are susceptible to.

In a <a href="http://cameronstokes.com/2009/02/10/flash-erase-operation-failed-sil3114/">previous post</a> I mentioned trying <a href="http://en.wikipedia.org/wiki/ZFS">ZFS</a>.  I scrapped that idea when I found you can't expand a ZFS <a href="http://en.wikipedia.org/wiki/ZFS#Storage_pools">zpool</a> by adding single drives to the system.  You can add additional zpools to a zpool (not sure if my terminology is right there) but that means adding an equal amount of storage to your existing array when you want to upgrade.  This means if I have 4 drives in a zpool, I'd have to add another 4 drives to upgrade.  You can also replace drives in the zpool with larger drives to expand them, but you have to replace each drive.  Neither option is very cost effective for me.  I was a little disappointed not to be able to try something new but have been happy with Linux and mdadm so it was not a difficult decision to go back to them.

I ordered 6 drives from Amazon and once they arrived I assembled them into a RAID 6 array.  mdadm has to sync the newly created array but the array is online and can be used normally.  A quick <a href="http://en.wikipedia.org/wiki/Ext3">ext3</a> format and I have 3.6 TB of space available.

``` 
Filesystem            Size  Used Avail Use% Mounted on
/dev/md0              3.6T  229G  3.2T   7% /opt/sata-array
```

After the format I started transferring my data which slows down the sync, but transferring all my data will take a few days anyway so the overall timeline doesn't really matter for me.  Doing a <strong>cat /proc/mdstat</strong> shows me the status of the array:

``` 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md0 : active raid6 sdf[5] sde[4] sdd[3] sdc[2] sdb[1] sda[0]
      3907049984 blocks level 6, 64k chunk, algorithm 2 [6/6] [UUUUUU]
      [======&gt;..............]  resync = 32.0% (312900864/976762496) finish=4727.0min speed=2340K/sec
unused devices: &lt;none&gt;
```

Short of having to setup a second computer to transfer the data, the entire process is very easy.  I feel better knowing my data is reasonably safe with RAID 6 even though I don't have a backup.  Backing up that much data is just too expensive to be worthwhile.
