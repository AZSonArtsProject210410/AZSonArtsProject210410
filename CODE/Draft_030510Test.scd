s.options.device = "Steinberg UR22mkII";
s.reboot;



s.meter;




//////////////////////////////// PRE - RECORDED SOUNDS ////////////////////////////////





// Trumpet_Drone


a = ~b1 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/κρατημένοι ήχοι/trumpet.wav" );
{PlayBuf.ar(2, ~b1)}.play;

(

    a =   {| amp = 0.1, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b1.bufnum]));



	a.set(\amp, 0.3);
    a.free;







// Inside_Athens_Soundscape



b = ~b2 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/ηχοτοπία/inside_Athens.wav" );
{PlayBuf.ar(2, ~b2)}.play;

(

	b =   { | amp = 0.3, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b2.bufnum]));



	b.set(\amp, 0.6);
    b.free;







// Trumpets_2 Drone


c = ~b3 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/κρατημένοι ήχοι/trumpets_2.wav" );
{PlayBuf.ar(2, ~b3)}.play;

(

    c =   { | amp = 0.1, buf = 0, rev = 0.3, room = 0.6 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
	    FreeVerb.ar(sig, rev, room);

}.play(args: [\buf, ~b3.bufnum]));


  c.set(\amp, 0.4, \rev, 0.4, \room, 0.6)
  c.free;







// Syntagma Sq.


d = ~b4 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/ηχοτοπία/Syntagma Sq.wav" );
{PlayBuf.ar(2, ~b4)}.play;

(

    d  =   { | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0|
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room, mix);

}.play(args: [\buf, ~b4.bufnum]));

d.set(\room, 0.2, \rev, 0.1, \amp, 0.3);

~b4.free;
d.free;


// b4 with grains synth

(

     d =   { | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0, agr = 0, bgr = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room, mix);
	    GrainIn.ar(1, Dust.ar(10), 0.08, sig);
}.play(args: [\buf, ~b4.bufnum]));


     d.set(\amp, 0.4, \room, 0.9, \mix, 0.9, \rev, 0,3, \agr, 10, \bgr, 0.1);
     ~b4.free;
      d.free;









///////////  INPUTS /////////////////////////////////



//LEFT MIC - CONTACT MIC

// επανάληψη χειρονομίας με καθυστέριση απόκρισης (maxd) /


(

y = SynthDef(\mic0, {
	arg in= 0, out=0, deltime= 0.2, mix = (- 0.3), decay = 1.5, amp= 0.5, rev = 0.3, room =0.3, delaytime = 0.8, maxd = 0.2;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	delay = DelayL.ar(sig, 1.5, SinOsc.kr(0.5).exprange(0.8,0.3), decay);
	delay = CombN.ar(sig, -5, 0.8, 0.9);
	sig = FreeVerb.ar(sig, rev, room);
	sig = XFade2.ar(sig, delay, mix, decay);
	sig = CombN.ar(sig, delaytime, maxd);
	sig = DelayL.ar(sig);
	Out.ar(out, sig);

}).add;
)

y = Synth(\mic0);
y.set(\rev, 0.5,\room, 0.7, \maxd, 1.9, \decay, 2)
y.free;




//r = signal Reverb

(

r = SynthDef(\mic0, {
	arg in= 0, out=0, amp= 0.8, rev = 0.7, room =0.8, damp = 0.6;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room);
	Out.ar(out, sig);

}).add;
)

r = Synth(\mic0);
r.set(\rev, 10,\room, 0.9)
r.free;







// RIGHT MIC - VOICE


(

z = SynthDef.new(\mic1,  {
	arg in= 1, out= 0, amp= 1;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	Out.ar(out, sig);

}).add;

)

z = Synth(\mic1);
z.set(\amp, 1;
z.free;




//u =  crackle

(

u = SynthDef.new(\mic1,  {
	arg in= 1, out= 0, amp= 1;
	var sig;
	sig = SoundIn.ar(in!2) * amp * Crackle.ar(2, 2, 0.5);
	Out.ar(out, sig);

}).add;

)

u = Synth(\mic1);
u.set(\amp, 1, \chaos, 1.4, \val, 2);
u.free;



//h = basic grain voice


(

h = SynthDef(\mic2,  {
	arg in= 1, out= 0, amp= 1, rev = 0.3, room =0.5, agr = 7, bgr = 0.06;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	sig = GrainIn.ar(1, Dust.ar(7), 0.06, sig);
	sig = FreeVerb.ar(sig, rev, room);
	Out.ar(out, sig);

}).add;

)

h = Synth(\mic2);
h.set(\room, 0.7, \agr, 20, \bgr, 5);
h.free;




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



























s.record;
s.stopRecording;








//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









