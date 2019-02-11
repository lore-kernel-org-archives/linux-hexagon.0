From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Date: Mon, 11 Feb 2019 11:55:37 +0100
Message-ID: <20190211105537.GA59133@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
 <20190211103927.GA118071@gmail.com>
 <20190211105214.GA30880@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
        b=QDtcr3wyAWwC1Feiwyp3X/8YTfaIdNpEWSGZejYjQTG/rj0trYk0vC6rQn4y2cNbXv
         il1Avd23/d1Hd8k+uTbZBtAoIRuLEkjW3uPerX4NcbTux104Th18LvFAtlUMw0zOO1LL
         tLmqEa0y4zRbQ5L3wXHA0BYGnh9on2hBdn58O1L8DaUmAwdWpiMdKB6WiTyS7C6wf6Bh
         MC78xcq2N19Sr8d1ee6X2SFh4BhB3mZOszFFAIe2XAVy/T1Xcb8vx1blQzxEH3d3ygOa
         1lUqargunUNH4IWUAEw1tmMjRZ4VOjSK4lFppReznME5P372JKKIbFQpvePfCELqMthw
         iSVw==
Content-Disposition: inline
In-Reply-To: <20190211105214.GA30880@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>


* Will Deacon <will.deacon@arm.com> wrote:

> On Mon, Feb 11, 2019 at 11:39:27AM +0100, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > Sounds good to me - I've merged this patch, will push it out after 
> > > testing.
> > 
> > Based on Peter's feedback I'm delaying this - performance testing on at 
> > least one key ll/sc arch would be nice indeed.
> 
> Once Waiman has posted a new version, I can take it for a spin on some
> arm64 boxen if he shares his workload.

Cool, thanks!

	Ingo
