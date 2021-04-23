From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 20:26:43 +0200
Message-ID: <CANiq72kNVDAiT+=SDuFNkC90=cJFqOYfHy60oiqsht6mcEDeYA@mail.gmail.com>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
 <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usW4K6lNB80DxgPMKXGwbs60wwBIL6B9yLZGCMNyXto=;
        b=RKHxCjbwiYoJu18YQepeMR8QGc0vnj8LX0se6valfLiMgyRphjvbPmL0/miLszk4wy
         z8tHgiA3gETAtwHTPdV93LWLoMHjYHk+gRJR76OiSloyQROuaRPl++UT9+2kM24a8uc5
         LfKflQoIm5HxQdstQmWvcZkpVOMJ4su1hHKqtdIcyzVix9lixDGLdwVeCD5O4CadZBJv
         DSKoFI4gJ/3XmgLvdhLCGs8sMIEscghdw6ZaEfmAg3pIC20MQxLAa7nSxD3DBeEmPGKM
         duvnUePvxjVei1WzXrXRSjG7+aSto5yuVXAt2Tz0MfAG/AJBPUH0d6+2b2nGVYgspUFx
         Pqqg==
In-Reply-To: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Brian Cain <bcain@codeaurora.org>, linux-arch <linux-arch@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On Fri, Apr 23, 2021 at 8:18 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Correct, as I understand it , work on gcc was stopped after the 4.6 release and
> any testing internally to Qualcomm was done using a patched clang. A few years
> ago this was said to be (almost?) entirely upstream, but as Nick points out
> it has never been possible to build an upstream hexagon kernel with an upstream
> clang.

It is pretty much dead code then. It would be a good idea to be a bit
more strict on this, i.e. not let archs linger in mainline if not
properly maintained. I would go even as far as requiring some public
CI logs for all architectures building -next/-rc as proof that some
configuration actually builds with some compiler, even if the compiler
is not an upstream one.

Cheers,
Miguel
