From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/2] mips/kgdb: prepare arch_kgdb_ops for constness
Date: Thu, 6 Dec 2018 18:05:41 +0000
Message-ID: <20181206180539.fezd6bqce36tgmie@pburton-laptop>
References: <75bbcdd1e9277d66ebb06e349dda304bd01ce761.1543957194.git.christophe.leroy@c-s.fr>
 <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XhW071/uoiAaefTgbrdRnxZSLzVFy3OC0TwnAGp6Um4=; b=SUeSSXWGiM9zA8
	dHRER4ulH6wwo3vqzeX7VnMrsQz+EWLdyY8qiL51JUEm9LEegeQW27jHBBdcpnT+ooMpNliDy12j9
	YI1WvnA6KMwNID+FpGNubY8LADhNNvWBwfx0zaQZCH/cJpfKzz3eWWl8bYb5mn4iOdotL0RPew5LV
	TxFt6B4g15fmHKqWw/gO0mIrqSn1edf53fwlDJhlnODml4MA+Rfl+A2D6geTxqVabXy78IrOKuG5C
	LcLRlooow9wj5wNbA4E0mE5Cw34EK4eh/pAXb4CGkWZA1UxZGK8Cimbzvx/RqUfWdsuMFAz7OHUCr
	YWBSDUgRI40Do8Xkq0Yg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7Ym/28FbfYFjo8Kau28UHz6Ma0/EBHpbuB4MA9ZmNI=;
 b=ChCPscR8Uxg6RfyDn0myrIV5KblnRMkUTNTTOz+L5BxblnB0gj4q09RvthSo1nfv8tE4T8W6yRsU6Aekf5vh6njYZrmlg2vhqz/XGVfu5s4jYXsxPuQaEWG5gQ71mIMSm0mfUdGMZAiZ/E1DsZ33DePsHZClPmEkRxaYd2gzuHE=
In-Reply-To: <20181206140902.ea6jlwqrbcwyxp5r@holly.lan>
Content-Language: en-US
Content-ID: <502BAAE9FE2E6E45B9CE975E9FA539FF@namprd22.prod.outlook.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Rich Felker <dalias@libc.org>, "Gustavo A. R.
 Silva" <gustavo@embeddedor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, linux-mips@vger.

Hi Christophe & Daniel,

On Thu, Dec 06, 2018 at 02:09:02PM +0000, Daniel Thompson wrote:
> On Wed, Dec 05, 2018 at 04:41:09AM +0000, Christophe Leroy wrote:
> > MIPS is the only architecture modifying arch_kgdb_ops during init.
> > This patch makes the init static, so that it can be changed to
> > const in following patch, as recommended by checkpatch.pl
> > 
> > Suggested-by: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> From my side this is
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Since this is a dependency for the next patch I'd be happy to take via
> my tree... but would need an ack from the MIPS guys to do that.

For both patches in this series:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
