\version "2.24.0"

global = {
  \key a \minor
  \time 4/4
  \tempo 4 = 100
}

% --- DRUMS ---
hatBar = \drummode { hh8 hh8 hh8 hh8 hh8 hh8 hh8 hh8 }
ksBar = \drummode { bd4 sn4 bd4 sn4 }
fillBar = \drummode { tommh8 tommh8 tomml8 tommh8 tommh8 tomml8 sn8 sn8 }

drumsPhrase = \drummode <<
  { \repeat unfold 7 { \hatBar | } \fillBar | }
\\
  { \repeat unfold 7 { \ksBar  | } \ksBar  | }
>>

drumsAll = \drummode { \repeat unfold 31 { \drumsPhrase } }

% --- HARMONY (Power chords: Am - G - F - G) ---
i   = { <a e' a'>2 <a e' a'>2 | }
VII = { <g d' g'>2 <g d' g'>2 | }
VI  = { <f c' f'>2 <f c' f'>2 | }

rockPhrase = { \i \i \VII \VII \VI \VI \VII \VII }
harmonyAll = \repeat unfold 31 { \rockPhrase }

% --- BASS (root-based rock bass) ---
bassI   = \relative c { a,4 a8 a8 a4 a8 a8 | }
bassVII = \relative c { g,4 g8 g8 g4 g8 g8 | }
bassVI  = \relative c { f,4 f8 f8 f4 f8 f8 | }

bassPhrase = { \bassI \bassI \bassVII \bassVII \bassVI \bassVI \bassVII \bassVII }
bassAll = \repeat unfold 31 { \bassPhrase }

% --- MELODY (simple pentatonic melody over the chords) ---
melodyPhrase = \relative c'' {
  % Bars 1-2: Am
  a4 c8 e8~ e4 d8 c8~ |
  c2 r4 a8 c8 |
  % Bars 3-4: G
  d4 e8 d8~ d4 c8 b8~ |
  b2 r4 g8 a8 |
  % Bars 5-6: F
  a4 c8 a8~ a4 g8 f8~ |
  f2 r4 e8 f8 |
  % Bars 7-8: G
  g4 a8 b8~ b4 c8 d8~ |
  d2 r2 |
}

melodyAll = \repeat unfold 31 { \melodyPhrase }

\score {
  <<
    \new DrumStaff \with { instrumentName = "Drums" } { \global \drumsAll }

    \new Staff \with { instrumentName = "Melody" } {
      \global
      \set Staff.midiInstrument = "electric guitar (clean)"
      \melodyAll
    }

    \new Staff \with { instrumentName = "Harmony" } {
      \global
      \set Staff.midiInstrument = "overdriven guitar"
      \harmonyAll
    }

    \new Staff \with { instrumentName = "Bass" } {
      \global
      \clef bass
      \set Staff.midiInstrument = "electric bass (finger)"
      \bassAll
    }
  >>
  \midi { }
}
