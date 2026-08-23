#compdef wget-2-zim
# https://github.com/ballerburg9005/wget-2-zim

_wget-2-zim() {
    _arguments '--any-max[max file size]:size_MB:()' \
               '--not-media-max[non-media file max size]:size_MB:()' \
               '--picture-max[picture file max size]:size_MB:()' \
               '--document-max[document file max size]:size_MB:()' \
               '--music-max[music file max size]:size_MB:()' \
               '--video-max[video file max size]:size_MB:()' \
               '--wget-depth[recursion depth (use 1 or 3 for shallow copies)]:depth:()' \
               '--include-zip[exclude archives from download]' \
               '--include-exe[exclude program files from download]' \
               '--include-any[download any file type]' \
               '--no-overreach-media[don'\''t download media files from external domains]' \
               '--overreach-any[download any inlined content from external domains]' \
               '--turbo[disable download delays]' \
               '--skip-download[skip downloading step & use existing files]' \
               '--creator=[custom creator string]:string:()' \
               '--publisher=[custom publisher string]:string:()' \
               '--description=[custom description]:string:()' \
               '--long-description=[custom long description]:string:()' \
               '--language=[ISO 639-3 language code]:code:()' \
               '--output=[custom output filename]:name:_files' \
               '--timestamp[add timestamp (YYYYMMDD_hhmmss) to ZIM filename]' \
               '--working-dir=[custom working directory]:path:_files' \
               '(- :)'{-h,--help}'[Print help message and exit]' \
               '1:url:(https:// http:// ftp://)' \
        && return 0
}
