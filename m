From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 00/21] dma-mapping: unify support for cache flushes
Date: Fri, 31 Mar 2023 17:53:45 +0100
Message-ID: <ZCcQGX/i8xBPiG7T@arm.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jKoUeqA3s/EnoS12/mr/7SE53gScjEYguAoPH39s79g=; b=nIAXJWz7aZcEFT
	AwsYzCSSfaj2h6QQgUzJwTbCFwcuct/JhQXiYHU+yIK+/M3qsuoNHXRaKhojudpgr1p3wLjKkAnej
	T0PBtuE95whn4BCgt/t63w519Tz5DxA2ajmb+qF2m2te/e2G/OAWhtfyVMZFdj59AsMNzqhVOzzkZ
	i9wlCLdNwBkCYHiYuPisatnk/oFgF4UYpQmXU8zXmf8cEyK5EQLOLaJTdJAZzYM21oUaPaIxwNjsF
	XQiQlkHoQuc7h2H/qva5OsftKqTjblFfMffXyYe+1BgSS+eGqs+9NhVW95USq/Ekj/Uw9UnzCOcKQ
	MS+EGyyY3ztV4ddZt+Lw==;
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph

On Mon, Mar 27, 2023 at 02:12:56PM +0200, Arnd Bergmann wrote:
> Another difference that I do not address here is what cache invalidation
> does for partical cache lines. On arm32, arm64 and powerpc, a partial
> cache line always gets written back before invalidation in order to
> ensure that data before or after the buffer is not discarded. On all
> other architectures, the assumption is cache lines are never shared
> between DMA buffer and data that is accessed by the CPU.

I don't think sharing the DMA buffer with other data is safe even with
this clean+invalidate on the unaligned cache. Mapping the DMA buffer as
FROM_DEVICE or BIDIRECTIONAL can cause the shared cache line to be
evicted and override the device written data. This sharing only works if
the CPU guarantees not to dirty the corresponding cache line.

I'm fine with removing this partial cache line hack from arm64 as it's
not safe anyway. We'll see if any driver stops working. If there's some
benign sharing (I wouldn't trust it), the cache cleaning prior to
mapping and invalidate on unmap would not lose any data.

-- 
Catalin
