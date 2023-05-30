import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayListModel {
  bool downloading = false;
  bool cancelDownload = false;
  bool completed = false;
  int progressBar = 0;
  late Video video;
  bool downloadStart = false;

  bool get getDownloadStart => downloadStart;

  void setDownloadStart(bool downloadStart) =>
      this.downloadStart = downloadStart;

  get getDownloading => downloading;

  void setDownloading(downloading) => this.downloading = downloading;

  get getCancelDownload => cancelDownload;

  void setCancelDownload(cancelDownload) =>
      this.cancelDownload = cancelDownload;

  get getCompleted => completed;

  void setCompleted(completed) => this.completed = completed;

  get getProgressBar => progressBar;

  void setProgressBar(progressBar) => this.progressBar = progressBar;

  get getVideo => video;

  void setVideo(Video video) {
    this.video = video;
  }
}
