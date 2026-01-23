\version "2.24.0"

% Little Wing Style - Reggae Feel in Em
% Bob Marley mood: one-drop drums, organ skank, melodic bass

global = {
  \key e \minor
  \time 4/4
  \tempo 4 = 68
}

% --- DRUMS (reggae one-drop: kick on 3, rim on 2 and 4) ---
hatBar = \drummode { hh8 hh8 hh8 hh8 hh8 hh8 hh8 hh8 }
oneDrop = \drummode { r4 ss4 bd4 ss4 }
fillBar = \drummode { sn8 sn8 tommh8 tomml8 tommh8 tomml8 sn4 }

drumsPhrase = \drummode <<
  { \repeat unfold 7 { \hatBar | } \fillBar | }
\\
  { \repeat unfold 8 { \oneDrop | } }
>>

drumsAll = \drummode { \repeat unfold 5 { \drumsPhrase } }

% --- ORGAN (Hammond B3 offbeat "skank" - reggae bubble) ---
organEm = { r8 <e g b>8 r8 <e g b>8 r8 <e g b>8 r8 <e g b>8 | }
organG  = { r8 <g b d'>8 r8 <g b d'>8 r8 <g b d'>8 r8 <g b d'>8 | }
organAm = { r8 <a c' e'>8 r8 <a c' e'>8 r8 <a c' e'>8 r8 <a c' e'>8 | }
organBm = { r8 <b, d fis>8 r8 <b, d fis>8 r8 <b, d fis>8 r8 <b, d fis>8 | }
organBb = { r8 <a c' e'>8 r8 <a c' e'>8 r8 <bes d' f'>8 r8 <bes d' f'>8 | }
organC  = { r8 <c' e' g'>8 r8 <c' e' g'>8 r8 <c' e' g'>8 r8 <c' e' g'>8 | }
organD  = { r8 <d' fis' a'>8 r8 <d' fis' a'>8 r8 <d' fis' a'>8 r8 <d' fis' a'>8 | }

organPhrase = { \organEm \organG \organAm \organEm \organBm \organBb \organC \organD }
organAll = \repeat unfold 5 { \organPhrase }

% --- GUITAR (clean offbeat chops - reggae skank) ---
guitarEm = { r4 <e g b e'>8 r8 r4 <e g b e'>8 r8 | }
guitarG  = { r4 <g b d' g'>8 r8 r4 <g b d' g'>8 r8 | }
guitarAm = { r4 <a c' e' a'>8 r8 r4 <a c' e' a'>8 r8 | }
guitarBm = { r4 <b, fis b d'>8 r8 r4 <b, fis b d'>8 r8 | }
guitarBb = { r4 <a c' e' a'>8 r8 r4 <bes d' f' bes'>8 r8 | }
guitarC  = { r4 <c e' g' c''>8 r8 r4 <c e' g' c''>8 r8 | }
guitarD  = { r4 <d fis' a' d''>8 r8 r4 <d fis' a' d''>8 r8 | }

guitarPhrase = { \guitarEm \guitarG \guitarAm \guitarEm \guitarBm \guitarBb \guitarC \guitarD }
guitarAll = \repeat unfold 5 { \guitarPhrase }

% --- BASS (melodic reggae bass - syncopated) ---
bassPhrase = \relative c, {
  % Em
  e4. g8 b4 g8 e8~ |
  % G
  e8 g4. b4 d8 b8 |
  % Am
  a4. c8 e4 c8 a8~ |
  % Em
  a8 e4. g4 b8 g8 |
  % Bm
  b,4. d8 fis4 d8 b8~ |
  % Am - Bb
  b8 a4. c4 f8 d8 |
  % C
  c4. e8 g4 e8 c8~ |
  % D
  c8 d4. fis4 a8 fis8 |
}

bassAll = \repeat unfold 5 { \bassPhrase }

\score {
  <<
    \new DrumStaff \with { instrumentName = "Drums" } { \global \drumsAll }

    \new Staff \with { instrumentName = "Guitar" } {
      \global
      \set Staff.midiInstrument = "electric guitar (clean)"
      \guitarAll
    }

    \new Staff \with { instrumentName = "Organ" } {
      \global
      \set Staff.midiInstrument = "rock organ"
      \organAll
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
