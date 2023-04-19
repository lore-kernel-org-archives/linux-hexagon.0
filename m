From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 08/21] riscv: dma-mapping: only invalidate after DMA, not flush
Date: Wed, 19 Apr 2023 07:22:50 -0700 (PDT)
Message-ID: <mhng-158f3971-b108-426f-b3e2-4f3c02a2199d@palmer-ri-x1c9>
References: <20230327121317.4081816-9-arnd@kernel.org>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=PvGgJpqcylwj1IoEjDuxj+UTLmSqrrSrw3kTv6dlqTM=; b=pHo7S1vG87RRBXjRm4D1ns9Xj6
	fbvKtpfMhalNVjWtI8VBHy3YAULZxsafxykSxrlaX2exqWWPpiIT28XBwrFTMvWIW23zC/uOwf7VC
	2zLW0gbYl0JaIks3nFo20qMNDsusn5siAL37TAjM4EJWySd6ilbcdr148mDHYRaruxeutt3bT1zBK
	fS4MPmcqsDvJEa9KBTxEl/tVeT9x2paXw1NHiJEuqpTxD6QkaZi9vPuBK5Ne6iYexQ2aj5/IRUuhm
	R/mvjiiAyZU4Wol8Iuf+U/fU+GRlM2Yc6qoUngChwCDu/sFPCfox6EgjLyzJT0XF1wo9Xvbp0dQNz
	svatws/Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681914171; x=1684506171;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqMbvZWHdx/umNn2GDsuDcOtpXqKSdzh2puSjeFvGNg=;
        b=BQQfPjXj9RjzqoAPS+lEslGY5dDcNNPEbJrUbMfagQ00SpueZWLcpYAadUOn4K2r/7
         h4HdkG7hv1lk/JwJJQYCK1kCSiFRuTmkN44fcy7kPteadqn38MkQ3ndJHP2Mc9t7NrZL
         nmp1DYP7b7nPYrKCi/AHIrNyGwWhrPzKd1bjeAAqOo6tX3/AL+K+6SRGBPhAsfYsDgSs
         dPS/aO0HTzlFjGLxzQlmfHBIIf93KsDsbdHG4ySz5E0QxtwHAyLnkpkj20M9cIgvdPfV
         aEw0KFtyNn5lgDQSa9YMyBJglZh/UHtAgTzAA5ieEsZiecFBH/5j299y8tclByk2q0hU
         dWkg==
In-Reply-To: <20230327121317.4081816-9-arnd@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: arnd@kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, vgupta@kernel.org, linux@armlinux.org.uk, neil.armstrong@linaro.org, linus.walleij@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren@kernel.org, bcain@quicinc.com, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, Paul Walmsley <paul.walmsley@sifive.com>, dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, jcmvbkbc@gmail.com, Christoph Hellwig <hch@lst.de>, robin.murphy@arm.com, prabhakar.mahadev-lad.rj@bp.renesas.com, Conor Dooley <conor.dooley@microchip.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m68k@lists

On Mon, 27 Mar 2023 05:13:04 PDT (-0700), arnd@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> No other architecture intentionally writes back dirty cache lines into
> a buffer that a device has just finished writing into. If the cache is
> clean, this has no effect at all, but if a cacheline in the buffer has
> actually been written by the CPU,  there is a drive bug that is likely
> made worse by overwriting that buffer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index d919efab6eba..640f4c496d26 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  		break;
>  	case DMA_FROM_DEVICE:
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	default:
>  		break;

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
