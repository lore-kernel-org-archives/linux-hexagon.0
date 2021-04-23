From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 20:17:49 +0200
Message-ID: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619201893;
        bh=e/Ao27bZlhQHDgXcpoTUwE3h91lxc91Kp/o0D/falf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QWSeXmKddMok/JeoNc7XhYPNRdCwX9BwjS+uH7kQpypIdEzupPeL/8tfOHYhC6k+y
         gME/vCMND+DK7Hjmal5q11oxTx8UHHVMSVnCtp1GEjNqVfBt1or+r7yPMc4QFWwOfv
         dBobaW7W+ZzBlEDzl/JfUkoDoNwChbM6dLcqLPiJM6GNagj6L6P1UHOoG/fw0wX2KV
         z2x7qNLDe2fk83WgfYjCDKZWZUZmoxoYMsEiewJaajWeS0A+HC05FsJA/IURg/pLOS
         UfqFiZPNBwIugTfNtJnv/elxEke98rV6IdL8DyCPeLl4TwgKRXLgnE/a1B/+UcBOx0
         h1ZA1NCk0K5VQ==
In-Reply-To: <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Brian Cain <bcain@codeaurora.org>, linux-arch <linux-arch@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>

On Fri, Apr 23, 2021 at 7:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 4/23/21 2:36 AM, Arnd Bergmann wrote:
> > [1] https://lore.kernel.org/lkml/04ca01d633a8$9abb8070$d0328150$@codeaurora.org/
>
> There is no current gcc C compiler in the 3 locations that I know of to look.
> The one I tried is v4.6 and it is too old to work with current makefiles.

Correct, as I understand it , work on gcc was stopped after the 4.6 release and
any testing internally to Qualcomm was done using a patched clang. A few years
ago this was said to be (almost?) entirely upstream, but as Nick points out
it has never been possible to build an upstream hexagon kernel with an upstream
clang.

       Arnd
