window.onload = function () {
    document.querySelectorAll('.window-loading')[0].classList.add('window-loaded');
    document.querySelectorAll('.window-loading')[0].classList.remove('window-loading');

    var videoElementWrap = document.querySelector('.video-cover'),
        videoElement = document.querySelector('.background-video'),
        partLoadingStatus = false;

    var xhr = new XMLHttpRequest();

    xhr.open('GET', 'video/background-video.mp4', true);

    xhr.send();

    videoElement.src = "video/background-video.mp4";

    xhr.onprogress = function (event) {
        if (event.loaded * 100 / event.total >= 10) {
            videoElementWrap.style.backgroundColor = "rgb(133, 133, 132)";
        }
        else if (event.loaded * 100 / event.total >= 9.5) {
            videoElementWrap.style.backgroundColor = "rgb(137, 137, 137)";
        }
        else if (event.loaded * 100 / event.total >= 9) {
            videoElementWrap.style.backgroundColor = "rgb(140, 140, 140)";
        }
        else if (event.loaded * 100 / event.total >= 8.7) {
            videoElementWrap.style.backgroundColor = "rgb(143, 143, 143)";
        }
        else if (event.loaded * 100 / event.total >= 8.4) {
            videoElementWrap.style.backgroundColor = "rgb(146, 146, 146)";
        }
        else if (event.loaded * 100 / event.total >= 8.1) {
            videoElementWrap.style.backgroundColor = "rgb(149, 149, 149)";
        }
        else if (event.loaded * 100 / event.total >= 7.8) {
            videoElementWrap.style.backgroundColor = "rgb(152, 152, 152)";
        }
        else if (event.loaded * 100 / event.total >= 7.5) {
            videoElementWrap.style.backgroundColor = "rgb(155, 155, 155)";
        }
        else if (event.loaded * 100 / event.total >= 7.2) {
            videoElementWrap.style.backgroundColor = "rgb(158, 158, 158)";
        }
        else if (event.loaded * 100 / event.total >= 6.9) {
            videoElementWrap.style.backgroundColor = "rgb(161, 161, 161)";
        }
        else if (event.loaded * 100 / event.total >= 6.6) {
            videoElementWrap.style.backgroundColor = "rgb(164, 164, 164)";
        }
        else if (event.loaded * 100 / event.total >= 6.3) {
            videoElementWrap.style.backgroundColor = "rgb(167, 167, 167)";
        }
        else if (event.loaded * 100 / event.total >= 6) {
            videoElementWrap.style.backgroundColor = "rgb(170, 170, 170)";
        }
        else if (event.loaded * 100 / event.total >= 5.7) {
            videoElementWrap.style.backgroundColor = "rgb(173, 173, 173)";
        }
        else if (event.loaded * 100 / event.total >= 5.4) {
            videoElementWrap.style.backgroundColor = "rgb(176, 176, 176)";
        }
        else if (event.loaded * 100 / event.total >= 5.1) {
            videoElementWrap.style.backgroundColor = "rgb(179, 179, 179)";
        }
        else if (event.loaded * 100 / event.total >= 4.8) {
            videoElementWrap.style.backgroundColor = "rgb(182, 182, 182)";
        }
        else if (event.loaded * 100 / event.total >= 4.5) {
            videoElementWrap.style.backgroundColor = "rgb(185, 185, 185)";
        }
        else if (event.loaded * 100 / event.total >= 4.2) {
            videoElementWrap.style.backgroundColor = "rgb(188, 188, 188)";
        }
        else if (event.loaded * 100 / event.total >= 3.9) {
            videoElementWrap.style.backgroundColor = "rgb(191, 191, 191)";
        }
        else if (event.loaded * 100 / event.total >= 3.6) {
            videoElementWrap.style.backgroundColor = "rgb(194, 194, 194)";
        }
        else if (event.loaded * 100 / event.total >= 3.3) {
            videoElementWrap.style.backgroundColor = "rgb(197, 197, 197)";
        }
        else if (event.loaded * 100 / event.total >= 3) {
            videoElementWrap.style.backgroundColor = "rgb(200, 200, 200)";
        }
        else if (event.loaded * 100 / event.total >= 2.7) {
            videoElementWrap.style.backgroundColor = "rgb(203, 203, 203)";
        }
        else if (event.loaded * 100 / event.total >= 2.4) {
            videoElementWrap.style.backgroundColor = "rgb(206, 206, 206)";
        }
        else if (event.loaded * 100 / event.total >= 2.1) {
            videoElementWrap.style.backgroundColor = "rgb(209, 209, 209)";
        }
        else if (event.loaded * 100 / event.total >= 1.8) {
            videoElementWrap.style.backgroundColor = "rgb(212, 212, 212)";
        }
        else if (event.loaded * 100 / event.total >= 1.5) {
            videoElementWrap.style.backgroundColor = "rgb(215, 215, 215)";
        }
        else if (event.loaded * 100 / event.total >= 1.2) {
            videoElementWrap.style.backgroundColor = "rgb(218, 218, 218)";
        }
        else if (event.loaded * 100 / event.total >= 0.9) {
            videoElementWrap.style.backgroundColor = "rgb(221, 221, 221)";
        }
        else if (event.loaded * 100 / event.total >= 0.6) {
            videoElementWrap.style.backgroundColor = "rgb(224, 224, 224)";
        }
        else if (event.loaded * 100 / event.total >= 0.3) {
            videoElementWrap.style.backgroundColor = "rgb(227, 227, 227)";
        }
        else if (event.loaded * 100 / event.total >= 0) {
            videoElementWrap.style.backgroundColor = "rgb(230, 230, 230)";
        }


        if (event.loaded * 100 / event.total >= 10) {
            if (!partLoadingStatus) {
                setTimeout(() => {
                    videoElementWrap.classList.add('video-playing');
                    videoElement.play();
                    partLoadingStatus = true;
                }, 4000);
            }
        }
    }
};

