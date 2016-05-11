From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [patch V4 02/31] bitops: Include generic parity.h in some
 architectures' bitops.h
Date: Wed, 11 May 2016 12:06:01 +0200
Message-ID: <20160511100601.GY24250@axis.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
 <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462957641-24241-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zengzhaoxiu@163.com
Cc: linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko

On Wed, May 11, 2016 at 05:06:17PM +0800, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Simply use the generic version.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no> [for avr32]

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
