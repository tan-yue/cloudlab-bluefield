"""Four r7525 nodes connected via three LANs.  Link speed is set to
100Gb/s and best effort. Each node has a read-only dataset mounted at
/mydata that contains the DOCA host deb image and the DOCA BlueField
image.

Instructions:
Wait for the experiment to start, and then log into one or more of the nodes
by clicking on them in the toplogy, and choosing the `shell` menu option.
Use `sudo` to run root commands.
"""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# Emulab specific extensions.
import geni.rspec.emulab as emulab

# Create a portal context, needed to defined parameters
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Create LANs
lans = []
nlans = 3
for i in range(nlans):
    lan = request.LAN()
    lan.best_effort = True
    # in kbps
    lan.bandwidth = "100000000"
    lans.append(lan)
    pass

# Process nodes, adding to link or lan.
for i in range(4):
    # Create a node and add it to the request
    name = "node" + str(i)
    node = request.RawPC(name)
    node.disk_image = 'urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD'
    # Add to the three LANs
    for j in range(nlans):
        iface = node.addInterface("eth" + str(j+1))
        lans[j].addInterface(iface)
        pass
    # set hardware type.
    node.hardware_type = "r7525"
    # mount the dataset holding necessary NVIDIA images to /mydata
    bs = node.Blockstore("bs", "/mydata")
    bs.dataset = "urn:publicid:IDN+clemson.cloudlab.us:praxis-pg0+imdataset+doca220ubuntu2204debbfb"
    # run startup.sh on each node
    node.addService(pg.Execute(
        shell="sh",
        command="sudo /local/repository/startup.sh &>> /local/logs/startup.log"))
    pass

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
