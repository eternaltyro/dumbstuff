#!/usr/bin/python

import boto.ec2

region_list={"Virginia":"us-east-1",
             "California":"us-west-1",
             "Oregon":"us-west-2",
             "Ireland":"eu-west-1",
             "Singapore":"ap-southeast-1",
             "Sydney":"ap-southeast-2",
             "Tokyo":"ap-northeast-1",
             "Sao Paulo":"sa-east-1"}

vol_id=[]
print
ACCESS_KEY=raw_input("Access Key: ")
SECRET_KEY=raw_input("Secret Key: ")

print "\nThe following regions are available:\n \n1. Virginia, 2. California, 3. Oregon, 4. Ireland, \n5. Singapore, 6. Sydney, 7. Tokyo, 8. Sao Paulo: \n\n"
region=raw_input("Region? :")
REGION=region_list[region]

if (ACCESS_KEY and SECRET_KEY):
    conn = boto.ec2.connect_to_region(REGION,aws_access_key_id=ACCESS_KEY,aws_secret_access_key=SECRET_KEY)
else:
    conn = boto.ec2.connect_to_region(REGION)

print "\n\nConnection to AWS established"

print "\n\nGetting Volumes..."
print

vol_id = conn.get_all_volumes()

if len(vol_id) == 0:
    print "No Volumes found!"
else:
    print "\nID\t\tCreation Time\t\tAttached Status\t\tVolume State"
    print "-----------------------------------------------------"
    for i in vol_id:
        print "%s\t%s\t%s\t%s" % (i.id, i.create_time, i.attachment_state(), i.volume_state())
    print

print "\n\nGetting Snapshots..."
print

snap_id = conn.get_all_snapshots(owner="self")

if len(snap_id) == 0:
    print "No Snapshots found!"
else:
    print "\nID\t\tCreation Time\t\tAttached Status\t\tVolume State"
    print "--------------------------------------------------------"
    for i in snap_id:
        print "%s\t%s\t%s\t%s\t%s" % (i.id, i.volume_id, i.volume_size, i.start_time, i.progress)
    print

if raw_input("\n\nCreate Snapshots for all volumes? [y/n] ") == 'y':
    print "\n\nSnapshotting all volumes..."
    for i in vol_id:
        snapshot_name = "snapshot of " + str(i)
        i.create_snapshot(description=snapshot_name)
        #snapshot = conn.create_snapshot(vol_id, snapshot_name)
else:
    vols_tbsnapped= raw_input("\n\nEnter the volume IDs to be snap shotted seperated by space: ")
    snapthese = map(str, vols_tbsnapped.split())
    if len(snapthese) == 0:
        print "None to snapshot. Bye!"
    else:
        print "\n\nSnapshotting..."
        for j in snapthese:
            snapshot_name = "snapshot of " + str(j)
            conn.create_snapshot(j, snapshot_name)
            print "Snapshot created for " + str(j)

#if raw_input("Do you want to delete snapshots? [y/n] ") == 'y':
#    print "Deleting all snapshots..."
#    for i in vol_id:
        
