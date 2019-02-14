From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
Date: Thu, 14 Feb 2019 20:38:55 +0200
Message-ID: <20190214183854.GA10795@rapoport-lnx>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
 <20190214170416.GA32441@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:In-Reply-To:MIME-Version:
	References:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Y5FG1XEVxvf9IK2l4OFuLfssAaEsRuwVLBuvenNYys=; b=GVC/vJCKrBJ7D5
	fnH53b5mpNcVp+9smNaye3Xnfz4Z5gHEwZeSIfgTkdWwsMMoNsDrH2FhhyVYfLYimBf9wHdCLkQDQ
	9Qvzw63tEVoMBAqS79w1rKU0Il2aPIX52GD1SQPEjU+mNRDatqizOJsIFqG5MukyFezzUj99TKouo
	ZQI1R/JtbjPiisyVFtAOX5Bpk/PiGiWjjH6LcnwhNR1+RSltZECvCMsM5EV88lIBMytNgsJ7BtjjJ
	uH11J7HEVej6RXU24nDmk7WE8Ze5xeJ9KVP2ZVT/ep69DSfiRFnhiK9ws6zpLxLFVAlx1P37GFBeT
	y6+MpfOkTTKeSg53GSdg==;
Content-Disposition: inline
In-Reply-To: <20190214170416.GA32441@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org

On Thu, Feb 14, 2019 at 06:04:16PM +0100, Christoph Hellwig wrote:
> This look fine to me, but I'm a little worried that as-is this will
> just create conflicts with my series..

I'll rebase on top of your patches once they are in. Or I can send both
series as a single set.
Preferences? 

-- 
Sincerely yours,
Mike.
