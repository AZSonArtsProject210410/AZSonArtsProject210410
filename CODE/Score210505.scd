


//////////////////////////////// PRE - RECORDED SOUNDS ////////////////////////////////





// Trumpet_Drone

(
a =   {| amp = 0.1, buf = 0 |
	var sig;
	sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b1.bufnum]));

a.set(\amp, 0.7);
a.free;


// Inside_Athens_Soundscape

(
b =   { | amp = 0.3, buf = 0 |
	var sig;
	sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b2.bufnum]));

b.set(\amp, 0.9);
b.free;



// Trumpets_2 Drone

(

c =   { | amp = 0.1, buf = 0, rev = 0.3, room = 0.6 |
	var sig;
	sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
	FreeVerb.ar(sig, rev, room);

}.play(args: [\buf, ~b3.bufnum]));


c.set(\amp, 0.2, \rev, 0.9, \room, 4)
c.free;



// Syntagma Sq.


(

d  =   { | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0|
	var sig;
	sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
	FreeVerb.ar(sig, rev, room, mix);

}.play(args: [\buf, ~b4.bufnum]));

d.set(\room, 0.2, \rev, 0.1, \amp, 0.3);


d.free;

// b4 with grains synth

(

d =   { | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0, agr = 0, bgr = 0 |
	var sig;
	sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
	FreeVerb.ar(sig, rev, room, mix);
	GrainIn.ar(1, Dust.ar(10), 0.08, sig);
}.play(args: [\buf, ~b4.bufnum]));


d.set(\amp, 0.04, \rev, 7, \room, 10, \mix, 5, \rev, 0,3, \agr, 0.2, \bgr, 0.2);
d.free;




///////////  INPUTS /////////////////////////////////



//LEFT MIC - CONTACT MIC



//  x = επανάληψη χειρονομίας με καθυστέριση απόκρισης (maxd) /

x = Synth(\mic0);
x.set(\amp, 0.6, \rev, 0.3,\room, 0.6, \maxd, 2, \delaytime, 2, \decay, 2, \mul, 1.2)
x.free;



// k = Reverb

k = Synth(\mic1);
k.set(\amp, 0.2, \rev, 0.2,\room, 0.2);
k.free;



//  r = signal Reverb + noise

r = Synth(\mic0);
r.set(\amp, 1.5, \rev, 0.3,\room, 0.7, \freq, 250, \mul, 1.5);

r.free;



//  y = reverb + noises - noisy drones

y = Synth(\mic0);
y.set(\amp, 1, \rev, 0.1,\room, 0.1, \maxd, 0.2, \delaytime, 0.3, \decay, 2, \freq, 230,  \mul, 1.5, \freqL, 50, \mulL, 1.6)
y.free;



//  f = XFader2

f = Synth(\mic0);
f.set(\amp, 0.2, \mix, -0.3, \decay, 0.2, \lo, 0.1, \hi, 0.8);

f.free;




// RIGHT MIC - VOICE////////


//  z = signal

z = Synth(\mic1);
z.set(\amp, 2.5);
z.free;



//  v = signal + reverb + delay

v = Synth(\mic2);
v.set(\amp, 1.6, \rev, 0.3, \room, 0.8, \decay, 0.3, \mul, 0.98);
v.free;



//  u =  LFNoisel voice impulses low tones

u = Synth(\mic1);
u.set(\amp, 1.3, \rev, 2, \room, 0.9, \freq, 840, \mul, 2.5 );
u.free;



//  h = "indian" voice drone

h = Synth(\mic2);
h.set(\amp, 1, \rev, 0.3, \room, 0.6, \revAmp, 2, \freq, 300, \mul, 1.3);
h.free;





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




s.record;
s.stopRecording;








//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









