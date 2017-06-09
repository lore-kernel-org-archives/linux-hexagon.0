From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/35] defconfig: Cleanup from old entries
Date: Fri, 9 Jun 2017 21:59:48 +0200
Message-ID: <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
References: <20170608160836.12196-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bOvgh01oFYvTEqrdbLtQyFqtzIFSF4y33zFpXIJixNo=; b=H5LdCq38whACiN
	+1yujwN/NhQUqakrevnYlHBuK+7w2qSmu/+UNo0/7CpZQRPbNsTdtf75IPx3vG/xengDbWTzkE7T1
	I8AF3nWKSLhTIozPJhxsFoVyleITLrExnArJ8lhVI+/zfEtyjMoYeqwsA5FUg7QV+0tH93zfT6xZx
	mDJpQLpAj6TBT94NQhSgfCjOFHfV6Ptx0F0z+k5wKBrR3w9nDxAggGnHDOSM0CtQ1j55f2KFZaWKW
	aE4iJWRKdEOpXSX+fVBIcynYbDhKJDMYhm2g2+kZbGdUZT4xFiG1LMMjTQ7AoR+e9D7wgnkwJyIEa
	iJhfIx1JvZrOfJSAYtNw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:sender:in-reply-to:references:from:date:message-id
 :subject:to:cc;
 bh=M/BQl55VmesotpcAqSTq4QLVPVScYx1VDtsDCdeVK4g=;
 b=RpnkHqlv541c4ruRGaf7oqPvb88KfVLxq8iTdACPivcdeNvkewdyAW+i26ExF6npsC
 ZwJxGIR4UvZzes7kIW5FX49msBjAMdQkVWgga6cRYEb/lqUBkXzJkETNcE+BpkWbVUBo
 NHivxr09uSf9iqPiVa8pPc2FyafTnCWpa+A88kjLGH+w3IseKRyw12F/u089XHHnJ/io
 a/YrvhbZ2veTuAlTmgGAstuk5mFIicwiwLd5SQsXm+zfEE1cB7DQKCoE3hykdXXRRYeW
 NCB2Q3D1L2XZrfkfw3sEC47UYBv7fNmsB8p0FlWaTpRMvSy1csqSC/2CdJNWML/inGgA
 i9vA==
In-Reply-To: <20170608160836.12196-1-krzk@kernel.org>
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Liviu Dudau <liviu.dudau@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-sh@vger.kernel.org

On Thu, Jun 8, 2017 at 6:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
> similar obsolete entries in other files.
>
> Except the ARM, no dependencies.
> For ARM, the rest of patches depend on the first change (otherwise
> it might not apply cleanly).

Great work!

I looked at all the ARM patches, and everything looks good to me (the
changlog linewrapping may be suboptimal for readability in some cases,
if I had to say anything negative ;-) ).

Please add my Acked-by to the ARM patches and send a pull request.

        Arnd
