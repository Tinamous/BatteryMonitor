$fn=80;

// Width (Note pcb does not centre align).
// 120mm realisting minimum size
// with trunking
// Width of 140mm allows the aerial to be stuck to the top edge
width = 140;

// Overall length /mm (without aerial 117mm, With aerial 125mm)
length = 140;

enclosureHeight = 32; // Max for USB being in top part.
enclosureHeight = 32;

pcbWidth = 100;
pcbLength = 100;
pcbXOffset = (width - pcbWidth)/2 ;
//pcbYOffset = (length - pcbLength)/2 + 10;
// Keep the PCB 10mm from the top edge
// allows the aerial to be stuck down.
// make gap 21mm for Arduiono MRK 1000 (WiFi)
pcbYOffset = (length - pcbLength - 12);

echo ("pcbXOffset",pcbXOffset);
echo ("pcbYOffset",pcbYOffset);

// 20mm border around the PCB for connectors.

// Thickness of the base material.
baseHeight = 1.5;

// How height off the base the PCB wil lbe.
height = 8;

//wallThickness = 1.5;
wallThickness = 3;

// Diameter of the screw hole for the PCB mounts. 4.4mm works well for M3 heatfits.
pcbMountScrewHoleDiameter = 4.4;

// caseOptions
addSecondLowerTrunkingInlet = true;
addUsbOutletHole = true;
addPowerSideHoles = true;
addFetHoles = false; 
addSensorSideHoles = false;
addArduinoUsbHole = true;

addTopMiddleRoundConduitHole = false;
addMiddleRoundConduitHole = false;
addTwinConduitHoles = false;

addMountingTabs = true;

addMountingTabs = true;

conduitHoleDiameter = 22;
            
// Make it a nice distance appart for the holes.
// that doesn't change if the case is made larger
// allowing it to be swapped out.
twinHolesDistanceApart = 45;  // Gives round hole by USB...
//twinHolesDistanceApart = 90; // On the edges - good for USB access
twinHolesXOffset = (width - twinHolesDistanceApart) / 2;

module roundedCube(width, height, depth, cornerDiameter) {
//cornerDiameter = 5;
cornerRadius = cornerDiameter/2;

    translate([cornerDiameter/2,0,0]) {
        cube([width-cornerDiameter, height, depth]);
    }
    
    translate([0,cornerDiameter/2,0]) {
        cube([width, height-cornerDiameter, depth]);
    }
    
    translate([cornerRadius,cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([width-cornerRadius,cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([cornerRadius,height-cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([width-cornerRadius,height-cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
}

module screw(x,y, height) {
    translate([x,y, 0]) {
        cylinder(d=6.5, h=2);
    }
    
    translate([x,y, -4]) {
        cylinder(d=3, h=6);
    }
}

module pcb() {
    roundedCube(100,100, 1.6, 8);
    screw(5,5, height, baseHeight);
    screw(5,95, height, baseHeight);
    screw(95,5, height, baseHeight);
    screw(95,95, height, baseHeight);
    
    // Battery in
    translate([74, -14, 1.6]) {
        cube([12, 22, 14]);
    }
    
    // Charger out
    translate([90, 19, 1.6]) {
        cube([22, 12, 14]);
    }
    
    // Power out
    translate([90, 35, 1.6]) {
        cube([22, 12, 14]);
    }
    
    // FETs
    translate([90, 75, 1.6]) {
        cube([8, 5, 20]);
    }
    
    translate([90, 59+5, 1.6]) {
        cube([8, 5, 20]);
    }
    
    translate([90, 47+5, 1.6]) {
        cube([8, 5, 20]);
    }
    
    // USB socket
    translate([20.5, -25, 1.6]) {
        cube([13.5, 35, 8]);
    }
    
    // USB Plug into the socket
    translate([19.5, -50, 1.6]) {
        cube([15.5, 50, 8]);
    }
    
    // Analog 1..5
    translate([2, 75+5, 1.6]) {
        cube([8, 7, 20]);
    }
    
    translate([2, 63.5+5, 1.6]) {
        cube([8, 7, 20]);
    }
    
    translate([2, 51.5+5, 1.6]) {
        cube([8, 7, 20]);
    }
    
    translate([2, 39.5+5, 1.6]) {
        cube([8, 7, 20]);
    }
    
    translate([2, 24+5, 1.6]) {
        cube([8, 12, 20]);
    }
}

// Actually this needs to be a Sigfor module...
module arduino() {
    // Z position already at PCB top.
    cube([25,68,14.5]);
    // Headers and Battery terminal
    translate([0,10,0]) {
        cube([5,50,23]); // Includes battery connector
        translate([20,0,0]) {
            cube([5,36,23]);
        }
    }
      
    // USB
    translate([8, 68-5.5, 14.5]) {
        cube([8,5.5,3]);
    }
    
    // USB Plug
    translate([8 - (3/2), 68, 14.5 - 3]) {
        cube([11,22,8]);
    }
    
    // Aerial connector
    translate([16, 5, 24]) {
        cube([8,4,2.5]);
    }
}

module pcbMount(x,y, height, baseHeight) {
    translate([x,y, baseHeight-0.1]) {
        difference() {
            cylinder(d=10, h=height);
            cylinder(d=pcbMountScrewHoleDiameter, h=height);
        }
    }
}

module pcbMountPin(x,y, height, baseHeight) {
    translate([x,y, baseHeight-0.1]) {
        union() {
            cylinder(d=10, h=height);
            cylinder(d=pcbMountPinDiameter, h=height + 3);
        }
    }
}

module addPcbMounts() {
    // Use pins on the end two to make it easier to 
    pcbMount(5,5, height, baseHeight);
    pcbMount(95,5, height, baseHeight);
    
    pcbMount(5,95, height, baseHeight);
    pcbMount(95,95, height, baseHeight);
}

module base() {       

// Offset from Pcb X for the Power In port.    
//powerInPcbOffset = 69; // Align with PCB
powerInPcbOffset = 84; // Gives trunking holes on edge (works better for USB.)
trunkingPortWidth = 23;
// Make a second trunking inlet on the lower
// part and make it's offset from the left
// symetrical with the power inlet.
secondTrunkingXOffset = width - (pcbXOffset + powerInPcbOffset + trunkingPortWidth);

    
    difference() {
        union() {
            roundedCube(width, length, enclosureHeight , 10);
        }
        union() {
            translate([wallThickness, wallThickness, baseHeight]) {
                roundedCube(width-(wallThickness*2), length-(wallThickness*2), enclosureHeight , 10);
            }
            
            // Vertical Holes referenced to the PCB
            translate([0,pcbYOffset, 0]) {            
                
                if (addPowerSideHoles) {
                    // Charger & Output for 25mm trunking
                    translate([width-wallThickness - 0.01,19,baseHeight]) {
                        cube([wallThickness + 0.02, trunkingPortWidth, 12]);
                    }
                    
                    // Output
                    translate([width-5,35,baseHeight]) {
                        //cube([10, 12, 10]);
                    }
                }
                
                if (addFetHoles) {
                    // FETs
                    translate([width-5,61,baseHeight]) {
                        cube([10, 12, 12]);
                    }
                }
                
                if (addSensorSideHoles) {
                    // Analogs
                    translate([-5,53,baseHeight]) {
                        cube([10, 20, 12]);
                    }
                }
            }
        
            // Hotizontal Holes referenced to the PCB
            // PCB direct (USB)
            translate([pcbXOffset,0 ,0]) {                
                
                // Power in
                // Insert power connector on side
                // hole is right size for 25mm trunking.
                translate([powerInPcbOffset,-4,baseHeight]) {
                    cube([trunkingPortWidth, 10, 12]);
                }
                
                // Usb Plug cutout in relation to PCB Z height
                if (addUsbOutletHole) {
                    translate([18, -0.1, baseHeight + height]) {
                        #cube([18, wallThickness+0.2, 11]);
                    }
                }
                
                // Add a hole for the Arduino
                if (addArduinoUsbHole) {
                    //
                    translate([23, length - wallThickness - 0.01, baseHeight + height + 12]) {
                        #cube([14, wallThickness + 0.1, 10]);
                    }
                }
            }
            
            if (addSecondLowerTrunkingInlet) {
                translate([secondTrunkingXOffset, -4, baseHeight]) {
                    cube([trunkingPortWidth, 10, 12]);
                }
            }
                        
            if (addTopMiddleRoundConduitHole) {
                translate([width / 2, length+0.01, 15,]) {
                    rotate([90, 0,0]) {
                        cylinder(d=conduitHoleDiameter, h=wallThickness+0.1);
                    }
                }
            }
            

            // Add a single 20mm hole for round conduit
            // on the lower wall of the case
            if (addMiddleRoundConduitHole) {
                translate([width / 2, wallThickness+0.01, 15,]) {
                    rotate([90, 0,0]) {
                        cylinder(d=conduitHoleDiameter, h=wallThickness+0.1);
                    }
                }
            }
                        
            // add 2x 20mm holes for round 
            // conduit on the lower 
            if (addTwinConduitHoles) {
                translate([twinHolesXOffset, wallThickness+0.01, 15,]) {
                    rotate([90, 0,0]) {
                        cylinder(d=conduitHoleDiameter, h=wallThickness+0.1);
                    }
                    translate([twinHolesDistanceApart, 0, 0]) {
                        rotate([90, 0,0]) {
                            cylinder(d=conduitHoleDiameter, h=wallThickness+0.1);
                        }
                    }
                }
            }
        }
    }
    
    if (addMountingTabs) {
        translate([pcbXOffset,pcbYOffset,0]) {
            addPcbMounts();
        }
    }
    
mountingTabYOffset = 25;
    if (addMountingTabs) {
        mountingTab(-10, 10, mountingTabYOffset, true);
        mountingTab(-10, 10, length - mountingTabYOffset, true);
        mountingTab(width + 10, 10, mountingTabYOffset, false);
        mountingTab(width + 10, 10, length - mountingTabYOffset, false);
    }
}

module mountingTab(x, offset, y, leftSide) {

    translate([x,y,0]) {
        difference() {
            union() {
                cylinder(d=18, h=4);
                if (leftSide) {
                    translate([0, -9, 0]) {
                        cube([offset, 18, 4]);
                    }
                } else {
                    translate([-offset, -9, 0]) {
                        cube([offset, 18, 3]);
                    }
                }
            }
            union() {
                cylinder(d=6, h=10);
                translate([0,0,2]) {
                    cylinder(d=12, h=10);
                }
            }
        }
    }
}

base();

translate([pcbXOffset,pcbYOffset,0]) {
    translate([0,0,baseHeight + height]) {
        %pcb();
    }

    translate([18, 100-68, baseHeight + height + 1.6]) {
       %arduino();
    }
}