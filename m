From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
Date: Thu, 14 Feb 2019 10:09:44 -0800
Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
 <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
 b=ZPnbWkIaLF1fPpbhVu5fqt9VoWAh7zq9mqH5LmbreMaS/dFp/ga9ADBd1bUPfLNZVt
 9cmIVEyoT/T8O5y3yiREHXO6gcW+3HJveD69ZJigOCRdO+OvsnNK66RwV3oR7F6BHY0m
 nx+fInfaHOtcGNGfeA3vdOANp4vbwtRzlSmX4=
In-Reply-To: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waiman Long <longman@redhat.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 14, 2019 at 9:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The arm64 numbers scaled horribly even before, and that's because
> there is too much ping-pong, and it's probably because there is no
> "stickiness" to the cacheline to the core, and thus adding the extra
> loop can make the ping-pong issue even worse because now there is more
> of it.

Actually, if it's using the ll/sc, then I don't see why arm64 should
even change. It doesn't really even change the pattern: the initial
load of the value is just replaced with a "ll" that gets a non-zero
value, and then we re-try without even doing the "sc" part.

End result: exact same "load once, then do ll/sc to update". Just
using a slightly different instruction pattern.

But maybe "ll" does something different to the cacheline than a regular "ld"?

Alternatively, the machine you used is using LSE, and the "swp" thing
has some horrid behavior when it fails.

So I take it back. I'm actually surprised that arm64 performs worse. I
don't think it should. But numbers walk, bullshit talks, and it
clearly does make for worse numbers on arm64.

               Linus
