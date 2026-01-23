\version "2.24.0"

% Blues in G - Quick Change - BB King Style
% Shuffle feel, jazzy 7th voicings, classic blues sound

global = {
  \key g \major
  \time 4/4
  \tempo 4 = 100
}

% --- DRUMS (shuffle feel) ---
hatBeat = \drummode { \tuplet 3/2 { hh8 r8 hh8 } }
hatBar = \drummode { \hatBeat \hatBeat \hatBeat \hatBeat }
ksBar = \drummode { bd4 sn4 bd4 sn4 }
fillBar = \drummode { sn8 sn8 sn8 sn8 tommh8 tomml8 sn4 }

drumsPhrase = \drummode <<
  { \repeat unfold 11 { \hatBar | } \fillBar | }
\\
  { \repeat unfold 12 { \ksBar | } }
>>

drumsAll = \drummode { \repeat unfold 2 { \drumsPhrase } }

% --- HARMONY (Classic blues 7th voicings) ---
I  = { <g b d' f'>2. <g b d' f'>4 | }
IV = { <c e g' bes'>2. <c e g' bes'>4 | }
V  = { <d fis a' c''>2. <d fis a' c''>4 | }

% Quick-change 12-bar form (IV on bar 2)
bluesPhrase = { \I \IV \I \I \IV \IV \I \I \V \IV \I \V }
harmonyAll = \repeat unfold 2 { \bluesPhrase }

% --- BASS (walking blues bass) ---
bassI  = \relative c, { g4 b d e | }
bassIa = \relative c, { g4 b d dis | }
bassIV = \relative c, { c4 e g a | }
bassV  = \relative c, { d4 fis a b | }
bassVt = \relative c, { d4 e fis g | }

bassPhrase = { 
  \bassI \bassIV \bassI \bassIa 
  \bassIV \bassIV \bassI \bassIa 
  \bassV \bassIV \bassI \bassVt 
}
bassAll = \repeat unfold 2 { \bassPhrase }

\score {
  <<
    \new DrumStaff \with { instrumentName = "Drums" } { \global \drumsAll }

    \new Staff \with { instrumentName = "Harmony" } {
      \global
      \set Staff.midiInstrument = "electric guitar (jazz)"
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
