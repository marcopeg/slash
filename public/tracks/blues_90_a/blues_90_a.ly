\version "2.24.0"

global = {
  \key a \major
  \time 4/4
  \tempo 4 = 90
}

% --- DRUMS (straight eighths) ---
hatBar = \drummode { hh8 hh8 hh8 hh8 hh8 hh8 hh8 hh8 }
ksBar = \drummode { bd4 sn4 bd4 sn4 }
fillBar = \drummode { tommh8 tommh8 tomml8 tommh8 tommh8 tomml8 sn8 sn8 }

drumsPhrase = \drummode <<
  { \repeat unfold 11 { \hatBar | } \fillBar | }
\\
  { \repeat unfold 11 { \ksBar | } \ksBar | }
>>

drumsAll = \drummode { \drumsPhrase }

% --- HARMONY (A7 blues: I7-IV7-V7) ---
chordI  = { <a cis e g!>2 <a cis e g!>2 | }
chordIV = { <d fis a c>2 <d fis a c>2 | }
chordV  = { <e gis b d>2 <e gis b d>2 | }

% 12-bar blues form
bluesPhrase = {
  \chordI \chordI \chordI \chordI       % Bars 1-4: I7
  \chordIV \chordIV                      % Bars 5-6: IV7
  \chordI \chordI                        % Bars 7-8: I7
  \chordV \chordIV \chordI \chordV       % Bars 9-12: V7-IV7-I7-V7 (turnaround)
}

harmonyAll = { \bluesPhrase }

% --- BASS ---
bassI  = \relative d { a,4 e' a, e' | }
bassIV = \relative d { d,4 a' d, a' | }
bassV  = \relative d { e,4 b' e, b' | }

bassPhrase = {
  \bassI \bassI \bassI \bassI
  \bassIV \bassIV
  \bassI \bassI
  \bassV \bassIV \bassI \bassV
}

bassAll = { \bassPhrase }

\score {
  <<
    \new DrumStaff \with { instrumentName = "Drums" } { \global \drumsAll }
    \new Staff \with { instrumentName = "Harmony" } {
      \global
      \set Staff.midiInstrument = "electric piano 1"
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
