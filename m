From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 0/2] Consolidate redundant register/stack access code
Date: Tue, 09 Feb 2016 20:36:40 +1100
Message-ID: <1455010600.13384.3.camel@ellerman.id.au>
References: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1454996337-7935-1-git-send-email-dave.long@linaro.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Long <dave.long@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, "chengang@emindsoft.com.cn" <chengang@emindsoft.com.cn>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Denys Vlasenko <dvlasenk@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Rashmica Gupta <rashmicy@gmail.com>, Rich Felker <dalias@libc.org>, Richard Kuo <rkuo@codeaurora.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutro>

On Tue, 2016-02-09 at 00:38 -0500, David Long wrote:

> From: "David A. Long" <dave.long@linaro.org>
>
> Move duplicate and functionally equivalent code for accessing registers
> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> common kernel files.
>
> I'm sending this out again (with updated distribution list) because v2
> just never got pulled in, even though I don't think there were any
> outstanding issues.

A big cross arch patch like this would often get taken by Andrew Morton, but
AFAICS you didn't CC him - so I just added him, perhaps he'll pick it up for
us :D

cheers
