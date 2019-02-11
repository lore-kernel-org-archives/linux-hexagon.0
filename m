From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Date: Mon, 11 Feb 2019 11:39:27 +0100
Message-ID: <20190211103927.GA118071@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSMeJ85hCnV/mBF9GGGV6ArWIiKHCHYp6BfRp6LTcvk=;
        b=GHcTe/v4HLTE6/ZcIf6lGV4ciNnib00F0miBQKJ/h849hGbvpylts6FbdNzfzkLCoA
         kEZJZgxvXWR05iwQH6TglhLsW3luSoxuZSoOafur7xRkm+HucfsvvvyhrGCleinsdB7a
         kOKt6ePQGkkAvZgLGpAqxiZYf0kHWJJX9HQmrFTSGE8lrjQx6tIHXY3u/qip4OWoalqb
         n/9ukgVhnW2jvZYUZ+dkiFka5KTup8rI2fD7QxHZWg9FtOJS57KdgEu1/QdFsDsQrA7f
         f0yTITJvlyuX9LZ89piQz+46mR2R0uLfipoujrOoIEPaGnhfgup0ylO/7xEAA2KaP8sa
         Q7QQ==
Content-Disposition: inline
In-Reply-To: <20190211071159.GA55579@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Sounds good to me - I've merged this patch, will push it out after 
> testing.

Based on Peter's feedback I'm delaying this - performance testing on at 
least one key ll/sc arch would be nice indeed.

Thanks,

	Ingo
