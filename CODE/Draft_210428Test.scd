s.options.device = "Steinberg UR22mkII";
s.reboot;








//////////////////////////////// PRE - RECORDED SOUNDS ////////////////////////////////


// Trumpet_Drone


a = ~b1 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/κρατημένοι ήχοι/trumpet.wav" );
{PlayBuf.ar(2, ~b1)}.play;


(

a = SynthDef(\b1, {

     { | amp = 0.1, buf = 0,  |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b1.bufnum]));



	a.set(\amp, 0.1);
    a.free;




// Inside_Athens_Soundscape


(

b = ~b2 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/ηχοτοπία/inside_Athens.wav" );
{PlayBuf.ar(2, ~b2)}.play;



	b = { | amp = 0.3, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b2.bufnum]));



	b.set(\amp, 0.9);



// Trumpets_2 Drone


(

c = ~b3 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/κρατημένοι ήχοι/trumpets_2.wav" );
{PlayBuf.ar(2, ~b3)}.play;


   c = { | amp = 0.1, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);

}.play(args: [\buf, ~b3.bufnum]));


  c.set(\amp, 0.1)




// Syntagma Sq.

(

d = ~b4 = Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/ηχοτοπία/Syntagma Sq.wav" );
{PlayBuf.ar(2, ~b4)}.play;



d  = { | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0|
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room, mix);

}.play(args: [\buf, ~b4.bufnum]));


     d.set(\amp, 0.1, \room, 0.9, \mix, 0.3, \rev, 3,);
     ~b4.free;
      d.free;

(

d = SynthDef(\b4, {
	Buffer.read(s,"C:/Users/Agapi/Desktop/Hχητικά/ηχοτοπία/Syntagma Sq.wav" );
	{PlayBuf.ar(2, ~b4)}}).play;


{ | amp = 0.3, rev = 0.7, room =0.9, mix = 0.6, buf = 0, agr = 0, bgr = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room, mix);
	    GrainIn.ar(1, Dust.ar(10), 0.08, sig);
}.play(args: [\buf, ~b4.bufnum]));


     d.set(\amp, 0.9, \room, 0.9, \mix, 0.9, \rev, 0,3, \agr, 10, \bgr, 0.04);
     ~b4.free;
      d.free;




///////////  INPUTS ///////////////////



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


//u = signal

(

u = SynthDef.new(\mic1,  {
	arg in= 1, out= 0, amp= 1;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	Out.ar(out, sig);

}).add;

)

u = Synth(\mic1);
u.set(\amp, 1);
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



s.meter;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



























// choose buffer expample / crreate micromontages

a = ~b1 = Buffer.read(s, "C:/Users/Agapi/Desktop/Μουσική Πληροφορική/lp.wav");
{PlayBuf.ar(2, ~b1)}.play;

a = { | amp = 1, rev = 0.3, room =0.5, buf = 0 |
		var sig;
		sig = amp * PlayBuf.ar(2, buf, 0.5, loop: 0, doneAction: 2);
		FreeVerb.ar(sig, rev, room);
	}.play(args: [\buf, [~b1, ~b2, ~b3, ~b4, ~b5].choose.bufnum]);/////////choose buffer from array


a.set(\buf, [~b1, ~b2, ~b3, ~b4, ~b5].choose.bufnum

	);



e = { | amp = 0.1 | amp * PlayBuf.ar(2, ~b5, MouseY.kr(0.4, 3), loop: 1, doneAction: 2);}.play;

/////////



s.record;
s.stopRecording;








//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









