From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Date: Wed, 10 Apr 2019 16:15:44 +0800
Message-ID: <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian> <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KIbH7PQ/+EhCRd6dFZrUyEEKxdSCK+Tg4Azj5CZNfg=;
        b=KCS8BLMpQF7FI4UPjcgFc26LkSmUfBe3VGzCMx3ZQXdHUNJTkx5tli9AZ8r7Iv8FUv
         4UzY02RzFxJ996bZvBXBO0iy7goFr+cdhnCgxqgnVQgCu/SqOuySG5IDq7kStWJBTg+R
         iswlqAN9kH/D9/3rCVEHBTUA9eS1lOaZcrV5RUH+OeHtcsoFhSm9MRC43TfAkYKnQ76b
         XO7JK06H0lIwPGGFT0CfrvLbARQgfKH4iHbxJ7TvEo/ySpSrHMpmNYbvfCeQ9VWhkpqt
         xz/MCGxJmCm+tl4C2hM4n/O+Z0VeMYwzr1p7HlyMWvfhhjROcT0YPt6BVBTC4hmkJmS9
         PhuQ==
In-Reply-To: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waiman Long <longman@redhat.com>
Cc: Chen Rong <rong.a.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, "IngoMolnar@shao2-debian" <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation>

Hi, Waiman,

What's the status of this patchset?  And its merging plan?

Best Regards,
Huang, Ying
