From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [patch V4 02/31] bitops: Include generic parity.h in some
 architectures' bitops.h
Date: Wed, 11 May 2016 19:22:28 +0530
Message-ID: <5733391C.1080609@synopsys.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
 <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: zengzhaoxiu@163.com, linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux@lists.openrisc.net, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, linux-snps-ar

On Wednesday 11 May 2016 02:36 PM, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Simply use the generic version.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> [for avr32]

Acked-by: Vineet Gupta <vgupta@synopsys.com>  # for arch/arc

Thx,
-Vineet
