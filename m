From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Date: Fri, 12 Apr 2019 08:49:21 +0800
Message-ID: <CAC=cRTP38JmFWe8C=y6ew_m1Lswb8DghnqLtdiMc0EW_fyPH7g@mail.gmail.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian> <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
 <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com> <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWBpR9dyC+xLnfEFgXj9tuZsVDw3WOnEHHAmffrI+OI=;
        b=rxG5LfvmG1C32HozkkLevSvbpCrrv685/jmZpjprMmyNxtE2Q31fL6G9UOlE4AIO3h
         NrV1UtIwHzrDNoSm9wNa54wKqjSKHrlb0DovQGCQ87iw+Al7LUaZidbJHwF8rRpx3oue
         xTdo6CXkjvHkapqQtTAVywV3eZS+iUgyK3IhBCmyRJd9RW6papq6LEn0RyqBlYnp2j8/
         +/3GqT4QR0cF3gWvmGWA5DC9pILZPFqeC2PilE9b+aVAesqUS7aCXbRqokBYBRQc4bKx
         7DQafVtU8z2UkkIDUFuK5khaHkMOxSZzvHYXlROdjoMJIvWj0qfHvj/gEDzLQvfxDu7V
         Fg5g==
In-Reply-To: <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waiman Long <longman@redhat.com>
Cc: Chen Rong <rong.a.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, "IngoMolnar@shao2-debian" <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation>

On Thu, Apr 11, 2019 at 12:08 AM Waiman Long <longman@redhat.com> wrote:
>
> On 04/10/2019 04:15 AM, huang ying wrote:
> > Hi, Waiman,
> >
> > What's the status of this patchset?  And its merging plan?
> >
> > Best Regards,
> > Huang, Ying
>
> I have broken the patch into 3 parts (0/1/2) and rewritten some of them.
> Part 0 has been merged into tip. Parts 1 and 2 are still under testing.

Thanks!  Please keep me updated!

Best Regards,
Huang, Ying

> Cheers,
> Longman
>
