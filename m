From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional DMA
Date: Wed, 19 Apr 2023 07:22:51 -0700 (PDT)
Message-ID: <mhng-7529cf5a-4397-456f-b610-faa619d4faca@palmer-ri-x1c9>
References: <20230327121317.4081816-10-arnd@kernel.org>
Mime-Version: 1.0 (MHng)
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=MUSjTlH259eL/MXcjOW5jyIacESSHgnNU108jNWCL6w=; b=qoy+opnw6vIDjHF0R/h7wA07iG
	u4V91C9O4W+NYaUsBrbII+4ixQuZN2eO6SWLv/EawO6MHMkZ5ZYxzQjY6dw0KgkxbqIA5AFudztkY
	T+PrOBnNQ8l8pSWadZQXi8edyKv2UBLTdkK1tfz+wrUtNA/Wakl96zBtLquo/fZ6ncaRB2n2oF3oB
	ZeIDcFcJUlUqaU4RK7X+oXOfJ2nEZ3IOgRTkromKgyN+ALA1z5UUDDS6t1nrncBj+ih4hpAjmRy4j
	psV1AP37n5MDS2LgSLw0VGAcJFOpGGZ4/24vv4/IXqegEosD3G+ZXMuuy4HFM0Z8ZVQPZurC06c/q
	+p2VzpLA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681914172; x=1684506172;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvT99d3vu2s9u2HdXHuOsCskK0/5VChFq+aBcaoQwKM=;
        b=eJ51Lyhme8n3XB+0k6fcBFov9PY8/EUmTR8+nuSaGr7xBsijqIoLjwhsLzVxYH/nx0
         wauVowtfzqnaLMg0Md06tjLXI3lWkSGzsXedNOsMpQwkDCNvEtBTyQ19M/Yyo6D06BSV
         XNjXn0CGdLZl3nFWqDjNax+yB6CXLq01SwKNwyDS36uGnLYxQFXzNQuK/+7hScqPlZwX
         z+agJw/VCIGMUixwVDzm2XMnLSn8GR3DsnMXY+jrQCfbr9O1Le1uXDKTi2rYkt7oJ2Ce
         tyNNGrxSj0L54sdbIeiSTDtndMc3YiWnjyxMJLeRw/TsNRHsyFeDM9KNzzDNKUVPs4Et
         pKOQ==
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
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

On Mon, 27 Mar 2023 05:13:05 PDT (-0700), arnd@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
>
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index 640f4c496d26..69c80b2155a1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	default:
>  		break;

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
