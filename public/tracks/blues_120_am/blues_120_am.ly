\version "2.24.0"

global = {
  \key a \minor
  \time 4/4
  \tempo 4 = 120
}

% --- DRUMS (shuffle feel) ---
hatBeat = \drummode { \tuplet 3/2 { hh8 r8 hh8 } }
hatBar = { \hatBeat \hatBeat \hatBeat \hatBeat }
ksBar = \drummode { bd4 sn4 bd4 sn4 }
fillStandard = \drummode { tommh8 tommh8 tomml8 tommh8 tommh8 tomml8 sn8 sn8 }

drumsPhrase = \drummode <<
  { \hatBar }
\\
  { \ksBar }
>>

drumsAll = \drummode { \repeat unfold 12 { \drumsPhrase } }

% --- HARMONY (minor blues, half-note hits - BB King style comping) ---
i  = { <a c e g>2 <a c e g>2 | }
iv = { <d f a c>2 <d f a c>2 | }
V  = { <e gis b d>2 <e gis b d>2 | }

bluesPhrase = { \i \i \i \i \iv \iv \i \i \V \iv \i \V }
harmonyAll = \repeat unfold 12 { \bluesPhrase }

% --- BASS ---
bassI  = \relative c { a,4 e' a, e' | }
bassIV = \relative c { d,4 a' d a' | }
bassV  = \relative c { e,4 b' e b' | }

bassChorus = { \bassI \bassI \bassI \bassI \bassIV \bassIV \bassI \bassI \bassV \bassIV \bassI \bassV }
bassAll = \repeat unfold 12 { \bassChorus }

\score {
  <<
    \new DrumStaff \with { instrumentName = "Drums" } { \global \drumsAll }
    \new Staff \with { instrumentName = "Guitar" } {
      \global
      \set Staff.midiInstrument = "electric guitar (clean)"
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
