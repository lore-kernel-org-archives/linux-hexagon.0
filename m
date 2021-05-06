From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] hexagon changes for v5.13
Date: Thu, 6 May 2021 09:52:26 -0700
Message-ID: <CAHk-=wiOp-Q0sFhmzGy2R=uMNV7Q26yqjeKNnwCnXgffnuDc9Q@mail.gmail.com>
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
 <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com> <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWUyBsKmAFKnzuyTle8X+IqQwBw635MonpJL6f0XlXs=;
        b=Toi2dF2JP14eu4kDfyv/A1fcV9pf6T+Oy+B/5i1euIBOSEjCs0r1EEBYOP0PvA837S
         F3eZH0yldWBxMDKkApRB8/r4ihrk53nSarJ8P+bAJKHUUjAZxB6tuMnMXudJJCPPXAdJ
         ANsg5C6zlsR30xcTNcPKU1hbbeizg3CKUy4gI=
In-Reply-To: <81ecc015b1bd773f583cc86490e392a0@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon <linux-hexagon@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, sidneym@codeaurora.org, clang-built-linux <clang-built-linux@googlegroups.com>

On Thu, May 6, 2021 at 9:17 AM <bcain@codeaurora.org> wrote:
>
> I apologize -- in my initial account setup I'd done the key creation
> without a signing feature/capability.  So in order to sign the tag I
> realized I needed a new subkey for signing.  I tried broadcasting the
> new key but perhaps I did not send it correctly.  I'll try it again
> today.
>
> http://keyserver.ubuntu.com/pks/lookup?search=bcain&fingerprint=on&op=index

Ok, that ubuntu keyserver worked for me now, and I can verify the tag. Thanks.

         Linus
