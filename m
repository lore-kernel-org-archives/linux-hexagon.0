From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] hexagon changes for v5.13
Date: Thu, 6 May 2021 09:03:32 -0700
Message-ID: <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyVEBL+xt1SQPCegOBTUU+QFYg0wXbsBFOTlu91fBI0=;
        b=T0KSrzdSGE888MPYuUq4G9EM95hI7x6fGzbOVXyDI1FWHmes4gTalsGxdVnFz4ykq7
         XPdAI1NUBLfokLmeJRjRLyh5mwLSByqOeNom7T0l5aonABz7mxnLRjEMkTgWBgBtRAGP
         kki0T4yJ3PI9LTsSAcQCEI1a/QXBHL3xJR3O0=
In-Reply-To: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon <linux-hexagon@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, sidneym@codeaurora.org, clang-built-linux <clang-built-linux@googlegroups.com>

On Wed, May 5, 2021 at 2:10 PM <bcain@codeaurora.org> wrote:
>
> Please pull the following changes for Hexagon: they contain build fixes.

The pull looks fine, but I'm wondering what key you've signed this with?

I find your key 175C464E541B6D47 in the kernel.org pgpkeys archive,
but your tag was signed with RSA key 1A54AFB8E5646C32, which I don't
find.

And the standard keyservers are - as usual - not very helpful.

I'd have loved to see a key I recognize, and I was hoping to also see
that key signed by Richard Kuo. And maybe it is, but I can't find it..

Anyway, pulled, just hoping for some clarification,

                Linus
