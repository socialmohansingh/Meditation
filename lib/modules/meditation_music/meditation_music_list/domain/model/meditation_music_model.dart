class MeditationMusicMoodel {
  final int id;
  String title;
  String img;
  String audio;
  String chapter;

  String? titleNE;
  String? audioNE;
  String? chapterNE;

  String? titleHI;
  String? audioHI;
  String? chapterHI;

  String? titleS;
  String? audioS;
  String? chapterS;

  MeditationMusicMoodel({
    required this.id,
    required this.title,
    required this.img,
    required this.audio,
    this.chapter = "",
    this.titleNE,
    this.chapterNE,
    this.audioNE,
    this.titleHI,
    this.chapterHI,
    this.audioHI,
    this.titleS,
    this.chapterS,
    this.audioS,
  });

  factory MeditationMusicMoodel.fromJson(Map<String, dynamic> json) {
    return MeditationMusicMoodel(
      id: json["id"],
      img: (json["chapterImage"] as String?) ?? "",
      audio: json["chapterAudioEn"],
      title: json["chapterNameEn"],
      chapter: json["chapterNumberEn"],
      titleNE: json["chapterNameNe"],
      audioNE: json["chapterAudioNe"],
      chapterNE: json["chapterNumberNe"],
      titleHI: json["chapterNameHi"],
      audioHI: json["chapterAudioHi"],
      chapterHI: json["chapterNumberHi"],
      titleS: json["chapterNameSkt"],
      chapterS: json["chapterNumberSkt"],
      audioS: json["chapterAudioSkt"],
    );
  }

  String getTitle(String lang) {
    switch (lang) {
      case "np":
        return ((titleNE ?? "").isNotEmpty ? titleNE! : title);
      case "hi":
        return ((titleHI ?? "").isNotEmpty ? titleHI! : title);
      case "s":
        return ((titleS ?? "").isNotEmpty ? titleS! : title);
      default:
        return title;
    }
  }

  String getChapter(String lang) {
    switch (lang) {
      case "np":
        return ((chapterNE ?? "").isNotEmpty ? chapterNE! : chapter);
      case "hi":
        return ((chapterHI ?? "").isNotEmpty ? chapterHI! : chapter);
      case "s":
        return ((chapterS ?? "").isNotEmpty ? chapterS! : chapter);
      default:
        return chapter;
    }
  }

  String getAudio(String lang) {
    switch (lang) {
      case "np":
        return ((audioNE ?? "").isNotEmpty ? audioNE! : audio);
      case "hi":
        return ((audioHI ?? "").isNotEmpty ? audioHI! : audio);
      case "s":
        return ((audioS ?? "").isNotEmpty ? audioS! : audio);
      default:
        return audio;
    }
  }

  static List<MeditationMusicMoodel> musics = [
    MeditationMusicMoodel(
      id: 1,
      title: "Peace and Happy",
      audio:
          "http://manonasa.com/wp-content/uploads/2023/12/Relax-and-be-inspired.mp3",
      img:
          "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&w=1600",
    ),
    MeditationMusicMoodel(
      id: 2,
      title: "Chill Music",
      audio:
          "http://manonasa.com/wp-content/uploads/2023/12/om-namo-bhagavate-vasudevaya-m.mp3",
      img:
          "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    MeditationMusicMoodel(
      id: 3,
      title: "Afternoon Rain",
      audio: "http://manonasa.com/wp-content/uploads/2023/12/Invocation.mp3",
      img:
          "https://images.pexels.com/photos/807598/pexels-photo-807598.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    MeditationMusicMoodel(
      id: 4,
      title: "Northern Lights",
      audio:
          "http://manonasa.com/wp-content/uploads/2023/12/Gayatri-mantra-chanting.mp3",
      img:
          "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    MeditationMusicMoodel(
      id: 5,
      title: "Peace and Happy",
      audio:
          "http://manonasa.com/wp-content/uploads/2023/12/Healing-Piano-Soft-Music.mp3",
      img:
          "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&w=1600",
    ),
    MeditationMusicMoodel(
      id: 6,
      title: "Chill Music",
      audio: "http://manonasa.com/wp-content/uploads/2023/12/Grateful.mp3",
      img:
          "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    MeditationMusicMoodel(
      id: 7,
      title: "Afternoon Rain",
      audio:
          "http://manonasa.com/wp-content/uploads/2023/12/deep-meditation-om-432-hz.mp3",
      img:
          "https://images.pexels.com/photos/807598/pexels-photo-807598.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    MeditationMusicMoodel(
      id: 8,
      title: "Northern Lights",
      audio:
          "http://manonasa.com/wp-content/uploads/2023/12/deep-and-peaceful.mp3",
      img:
          "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
    MeditationMusicMoodel(
      id: 9,
      title: "Peace and Happy",
      audio:
          "http://codeskulptor-demos.commondatastorage.googleapis.com/descent/background%20music.mp3",
      img:
          "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&w=1600",
    ),
    MeditationMusicMoodel(
      id: 10,
      title: "Chill Music",
      audio: "http://manonasa.com/wp-content/uploads/2023/12/calm-winds.mp3",
      img:
          "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ),
  ];
}
