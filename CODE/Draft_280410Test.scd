s.options.device = "Yamaha Steinberg USB ASIO";





// επανάληψη χειρονομίας με καθυστέριση απόκρισης (maxd) /

(

y =
    SynthDef.new(\mic0, {
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
y.set(\rev, 0.5,\room, 0.4, \maxd, 2, \decay, 0.6)
y.free;




//Reverb

(

r = SynthDef.new(\mic0, {
	arg in= 0, out=0, amp= 0.5, rev = 0.7, room =0.8, damp = 0.6;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	sig = FreeVerb.ar(sig, rev, room);
	Out.ar(out, sig);

}).add;
)

r = Synth(\mic0);
r.set(\rev, 10,\room, 0.9)
r.free;













/////////



s.record;
s.stopRecording;








//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









