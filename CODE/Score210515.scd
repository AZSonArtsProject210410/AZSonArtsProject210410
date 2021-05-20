


Server.default.options.device = "2- Steinberg UR22mkII";





//////////////////////////////// PRE - RECORDED SOUNDS ////////////////////////////////





// Trumpet_Drone


a = ~b1 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/κρατημένοι ήχοι/trumpet.wav" );
{PlayBuf.ar(2, ~b1)}.play;

(

    a =   {| amp = 0.1, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b1.bufnum]));



	a.set(\amp, 0.8);
    a.free;





// Granular Sp.



b = ~b2 = Buffer.read(s, "C:/Users/Agapi/Desktop/Hχητικά/granular space.wav");
{PlayBuf.ar(2, ~b2)}.play;

(

	b =   { | amp = 0.3, buf = 0 |
		var sig, val;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b2.bufnum]));



    b.set(\amp, 0.4);
    b.free;





// Trumpets_2 Drone


c = ~b3 = Buffer.read(s,"C:/Users/Agapi/D\esktop/Hχητικά/κρατημένοι ήχοι/trumpets_2.wav" );
{PlayBuf.ar(2, ~b3)}.play;

(

    c =   { | amp = 0.1, buf = 0, rev = 0.3, room = 0.6 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
	    FreeVerb.ar(sig, rev, room);

}.play(args: [\buf, ~b3.bufnum]));


  c.set(\amp, 1.5, \rev, 0.9, \room, 9)
  c.free;




// Syntagma Sq.grains


d = ~b4 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/ηχοτοπία/Syntagma Sq.wav" );
{PlayBuf.ar(2, ~b4)}.play;

(

     d =   { | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0, agr = 0, bgr = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room, mix);
	    GrainIn.ar(1, Dust.ar(10), 0.08, sig);
}.play(args: [\buf, ~b4.bufnum]));


     d.set(\amp, 0.0, \rev, 7, \room, 10, \mix, 0.4, \rev, 0,3, \agr, 0.3, \bgr, 0.3);
     ~b4.free;
      d.free;





///////////  INPUTS /////////////////////////////////



//LEFT MIC - CONTACT MIC



//  x = επανάληψη χειρονομίας με καθυστέριση απόκρισης (maxd) /


(

x = SynthDef(\mic0, {
	arg in= 0, out=0, amp= 0.5, rev = 0.3, room =0.3, maxd = 0.2, delaytime = 0.8, decay = 1.5, mul = 0.5;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room);
	delay = CombL.ar(sig, 0.2, 0.8, 0.9);
	sig = CombL.ar(sig, delaytime, maxd, mul);
	Out.ar(out, sig);

}).add;
)

x = Synth(\mic0);
x.set(\amp, 0.6, \rev, 0.3,\room, 5, \maxd, 0.3 , \delaytime, 0.2, \decay, 2, \mul, 1.2)
x.free;


///μόνο Reverbv  CON

(

 k = SynthDef.new(\mic0,  {
	arg in= [0,1], out= 0, amp= 1, freq = 500, rev = 0.3, room =0.3;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room);
	Out.ar(out, sig);

}).add;

)

k = Synth(\mic0);
k.set(\amp, 0.2, \rev, 0.2,\room, 0.1);
k.free;





//   r = signal Reverb + noise    CON

(

r = SynthDef(\mic0, {
	arg in= [0,1], out=0, amp= 0.8, rev = 0.7, room =0.8, freq = 600, mul = 0.5;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room) * LFDNoise3.kr(freq, mul);
	Out.ar(out, sig);

}).add;
)

r = Synth(\mic0);
r.set(\amp, 0.5, \rev, 0.3,\room, 0.5, \freq, 50, \mul, 2.5);

r.free;



//  y = reverb + noises - noisy drones   CON

(

y = SynthDef(\mic0, {
	arg in= 0, out=0, amp= 0.5, rev = 0.3, room =0.3, maxd = 0.2, delaytime = 2, decay = 1.5, freq = 500, mul = 1.5,        freqL = 400, mulL = 0.3;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room);
	delay = CombN.ar(sig, 0.2, 0.8, 0.9);
	sig = CombN.ar(sig, delaytime, maxd) * LFDNoise0.kr(freq, mul) * LFClipNoise.kr(freqL, mulL) ;


	Out.ar(out, sig);

}).add;
)

y = Synth(\mic0);
y.set(\amp,0., \rev, 3,\room, 0.6, \maxd, 2, \delaytime, 1, \decay, 2, \freq, 150,  \mul, 2.5, \freqL, 550, \mulL, 2.6)
y.free;




//  f = XFader2   CON

(

f = SynthDef(\mic0, {
	arg in= [0,1], out=0, mix=(-0.8), decay=3, amp=1, lo = 0.9, hi = 0.5;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	delay = CombL.ar(sig, 2, SinOsc.kr(8).exprange(lo, hi), decay);
	sig = XFade2.ar(sig, delay, mix);
	Out.ar(out, sig);

}).add;
)

f = Synth(\mic0);
f.set(\amp, 0.4, \mix, 3, \decay, 0.4, \lo, 0.1, \hi, 0.3);

f.free;



// Eli's harmonizer
(
SynthDef(\mic0, {
	var sig, phs, del, env, rate, maxdel=0.05;
	rate = \n.kr(0).midiratio - 1 / maxdel;
	sig = SoundIn.ar(\in.ir(0), 2);
	phs = LFSaw.ar(rate.neg, [1,0]).range(0,maxdel);
	env = SinOsc.ar(rate, [3pi/2,pi/2]).range(0,1).sqrt;
	del = DelayC.ar(sig, maxdel, phs) * env;
	del = del.sum!2 * \amp.kr(0.85);
	Out.ar(\out.ir(0), del);
}).add;
)

~del = Synth(\mic0, [\in, ~fxBus], ~fxGrp);
~del.set(\n, 9);

(
~del = [
	Synth(\mic0, [\in, ~fxBus, \n, -3], ~fxGrp),
	Synth(\mic0, [\in, ~fxBus, \n, 2], ~fxGrp),
	Synth(\mic0, [\in, ~fxBus, \n, 4], ~fxGrp),
	Synth(\mic0, [\in, ~fxBus, \n, -0.3], ~fxGrp),
];
)





// RIGHT MIC - VOICE////////


// z = signal

(

    z = SynthDef.new(\mic1,  {
	arg in= 1, out= 0, amp= 1, freq = 500;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	Out.ar(out, sig);

}).add;

)

z = Synth(\mic1);
z.set(\amp, 0.6);
z.free;





// v = signal + reverb + delay   VOICE

(

	v = SynthDef.new(\mic1,  {
	arg in= 1, out= 0, amp= 1, rev = 0.3, room =0.5, decay = 3, mul = 0.8;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room);
	sig = CombN.ar(sig, decay, mul);
	Out.ar(out, sig);

			}).add;

)

v = Synth(\mic1);
v.set(\amp, 0.2, \rev, 0.9, \room, 0.2, \decay, 0.2, \mul, 1.8);
v.free;





// u =  LFNoisel voice impulses low tones   VOICE

(

u = SynthDef.new(\mic1, {
	arg in= 1, out= 0, amp= 1, rev = 0.3, room = 0.9, freq = 500, mul = 0.5;
	var sig;
	sig = SoundIn.ar(in!2) * amp * LFNoise1.kr(freq, mul);
	sig = FreeVerb.ar(sig, rev, room);
	Out.ar(out, sig);

}).add

)

u = Synth(\mic1);
u.set(\amp, 0.5, \rev, 0.2, \room, 0.3, \freq, 40, \mul, 0.8 );
u.free;



//h = basic grain voice     VOICE

(

	h = SynthDef.new(\mic1,  {
	arg in= 1, out= 0, amp= 1, rev = 0.3, room =0.5, revAmp = 2, freq = 440, mul = 1.5 ;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room) * revAmp * LFClipNoise.kr(freq, mul);
	Out.ar(out, sig);

			}).add;

)

h = Synth(\mic1);
h.set(\amp, 0.7, \rev, 0.3, \room, 2, \revAmp, 2, \freq, 50, \mul, 1.8);
h.free;





//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/// Μicromontage


a = ~b1 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b1.wav" );
{PlayBuf.ar(2, ~b1)}.play;


a = ~b2 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b2.wav" );
{PlayBuf.ar(2, ~b2)}.play;


a = ~b3 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b3.wav" );
{PlayBuf.ar(2, ~b3)}.play;


a = ~b4 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b4.wav" );
{PlayBuf.ar(2, ~b4)}.play;


a = ~b5 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b5.wav" );
{PlayBuf.ar(2, ~b5)}.play;


a = ~b6 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b6.wav" );
{PlayBuf.ar(2, ~b6)}.play;


a = ~b7 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/b7.wav" );
{PlayBuf.ar(2, ~b7)}.play;


a = ~b8 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/s1.wav" );
{PlayBuf.ar(2, ~b8)}.play;


a = ~b9 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/samples και μικρομοντάζ/s2.wav" );
{PlayBuf.ar(2, ~b9)}.play;






(

a = { | amp = 1, rev = 0.3, room =0.5, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, 0.5, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room);
	}.play(args: [\buf, [~b1, ~b2, ~b3, ~b4, ~b5, ~b6, ~b7, ~b8, ~b9].choose.bufnum]);



)

a.set(\amp, 3);
a.free;

















//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

s.meter;


s.record;
s.stopRecording;







