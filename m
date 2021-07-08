From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: how can we test the hexagon port in mainline
Date: Thu, 8 Jul 2021 12:08:44 -0700
Message-ID: <CAKwvOdkQhq-hPr=S52D=kJVPGP507F78hY2PbC+hbuq3MZUkDw@mail.gmail.com>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de>
 <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
 <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain> <20210707141054.GA24828@lst.de>
 <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org> <20210708052751.GA18789@lst.de>
 <CAKwvOd=iRLQPum8-jaCG90TPyxDptNB31yRHMEWgSMxjv=KuHA@mail.gmail.com> <0a6801d77428$13c88060$3b598120$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxq/oYeE5el0szoQlSwnFi3D5C8UV0iamECRppUCTb8=;
        b=CS3c/rCTZLRhfSZCtAFxKSJZw+1e1IR2isTofp5binEMsCyeotR+El3bf6mQCQ7wzV
         jWJVrjKqwkUrl/VQ13p+AJp8e9SLTn3+uYldNdocc5FmU6w/ISh4Hjnj12WnLq/EThgO
         RbZbkm4tf7VyU3WqQYrHzFeeclUlFPuNKfF+ya3FOwYmCiWCvShmMWhtzPePt/2e6muW
         holGzqrc5CfzyDkjL6U+Obpw4PhbRyRoFodiF7RVOGG4BUOmfOSeC11wHIYOKds4+G3B
         DC2PS92JFmb/Unb81kfVM9358a4QlEBNkQ13Q/EUOUtc2N7DO9nV0/mST0Mi/s2lpHWG
         e87g==
In-Reply-To: <0a6801d77428$13c88060$3b598120$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org
Cc: Christoph Hellwig <hch@lst.de>, "Manning, Sid" <sidneym@quicinc.com>, Nathan Chancellor <nathan@kernel.org>, Sid Manning <sidneym@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Thu, Jul 8, 2021 at 11:36 AM Brian Cain <bcain@codeaurora.org> wrote:
>
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > We're looking into statically linked images of clang to prevent these
> > kinds of games.
>
> Statically linking against libc++/libc++abi at least seems like a good idea.  Let me know if we can help.

Consider subscribing/reading/posting to
https://github.com/ClangBuiltLinux/tc-build/issues/150.
-- 
Thanks,
~Nick Desaulniers
