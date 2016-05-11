From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch V4 02/31] bitops: Include generic parity.h in some
 architectures' bitops.h
Date: Wed, 11 May 2016 11:42:05 +0100
Message-ID: <20160511104205.GE3051@e104818-lin.cambridge.arm.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
 <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zengzhaoxiu@163.com
Cc: linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux@lists.openrisc.net, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, linux-snps-arc@lists.infradead.org, Haavard

On Wed, May 11, 2016 at 05:06:17PM +0800, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Simply use the generic version.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> [for avr32]
> ---
>  arch/arc/include/asm/bitops.h      | 1 +
>  arch/arm/include/asm/bitops.h      | 1 +
>  arch/arm64/include/asm/bitops.h    | 1 +
>  arch/avr32/include/asm/bitops.h    | 1 +
>  arch/c6x/include/asm/bitops.h      | 1 +
>  arch/cris/include/asm/bitops.h     | 1 +
>  arch/frv/include/asm/bitops.h      | 1 +
>  arch/h8300/include/asm/bitops.h    | 1 +
>  arch/hexagon/include/asm/bitops.h  | 1 +
>  arch/m32r/include/asm/bitops.h     | 1 +
>  arch/m68k/include/asm/bitops.h     | 1 +
>  arch/metag/include/asm/bitops.h    | 1 +
>  arch/mn10300/include/asm/bitops.h  | 1 +
>  arch/openrisc/include/asm/bitops.h | 1 +
>  arch/parisc/include/asm/bitops.h   | 1 +
>  arch/s390/include/asm/bitops.h     | 1 +
>  arch/sh/include/asm/bitops.h       | 1 +
>  arch/xtensa/include/asm/bitops.h   | 1 +

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
