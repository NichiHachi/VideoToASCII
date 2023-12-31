CXX = g++
CXX_C = gcc
CXXFLAGS = -I/usr/include/opencv2
LDFLAGS = -L/usr/local/lib
LDLIBS = -lsfml-graphics -lSDL2main -lSDL2 -lSDL2_image -lSDL2_ttf
LDLIBS_OPENCV = -lopencv_calib3d -lopencv_highgui -lopencv_core -lopencv_video -lopencv_videoio -lopencv_photo -lopencv_imgcodecs -lopencv_imgproc

all : VideoToASCII video_FPS_counter main

main : main.c
	$(CXX_C) $< -o $@ $(shell pkg-config --cflags --libs gtk+-3.0)

video_FPS_counter: video_FPS_counter.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(LDFLAGS) $(LDLIBS_OPENCV)

VideoToASCII: VideoToASCII.cpp ascii_to_frame.o chara_to_matrix.o frame_to_ascii.o frame_to_video.o video_to_frame.o
	$(CXX) $^ -o $@ $(CXXFLAGS) $(LDFLAGS) $(LDLIBS) $(LDLIBS_OPENCV)

ascii_to_frame.o: ascii_to_frame.cpp
	$(CXX) -c $<

chara_to_matrix.o: chara_to_matrix.cpp
	$(CXX) -c $<

frame_to_ascii.o: frame_to_ascii.cpp
	$(CXX) -c $<

frame_to_video.o: frame_to_video.cpp
	$(CXX) -c $< $(CXXFLAGS) $(LDFLAGS) $(LDLIBS_OPENCV) -o $@

video_to_frame.o: video_to_frame.cpp
	$(CXX) -c $< $(CXXFLAGS) $(LDFLAGS) $(LDLIBS_OPENCV) -o $@

clean:
	rm *.o
	rm VideoToASCII
	rm video_FPS_counter
	rm main
	rm *.txt
	rm *.mp4