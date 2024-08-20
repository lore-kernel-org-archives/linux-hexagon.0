Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAFA93D;
	Tue, 20 Aug 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115950; cv=none; b=G0L/2c9+nIOVYJVH3BsztiW3Idq1MSjjCtdtwDvF3+90T85LrDsyLQbL+WanIbwCuTLd5TpxpT7dJh5jLMaE8PMlIYvVnRksiOc7lMe6EQ8+/VJIYp+trXfcXcm9BId+qQgeLomeOkesWD+0U75orLbkYa4M/zbN070trmdFVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115950; c=relaxed/simple;
	bh=0U7jOid/uP8Y+iIqM7ITqWrx8b2Snwx2qFv6PcPMlns=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kPFSQ1orFLn2kYINcP7nlhTF1smNqgHo6DdnhEEbEASPeGTe5e3PVeZoeBczZnGjCErGWTluULKa2FQyuT4BKBiHfDoHYDA5cP4PB7IFSuPQAzxI+nULXs2rEVdeMn6EIOMKviXxaheZU+M1emYJsu3M15mwbZBglje3IU3+N+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ohr8uPnM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ohr8uPnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA95FC32782;
	Tue, 20 Aug 2024 01:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724115949;
	bh=0U7jOid/uP8Y+iIqM7ITqWrx8b2Snwx2qFv6PcPMlns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ohr8uPnMeT9PqbC27FNE2NUgwBSpD2Am8ljUhb2MkNtpvuqCxRgINXdfU+7Z5Ok4Q
	 oLhpzo7qQb2Jy/L9reXhcowB+4RKVOZlFzvsJaEDLoJ4G/pXRebjYmXlqoj8xddMJJ
	 umSfjfzu/bhamoXfiWzuJ1aWiSlwUJ4EuI/WZtuw=
Date: Mon, 19 Aug 2024 18:05:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-Id: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
	<20240819195120.GA1113263@thelio-3990X>
	<CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
	<CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 13:16:32 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 19 Aug 2024 at 13:15, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok, I did a quick hack-job to remove that disgusting
> > install_special_mapping() legacy case.
> >
> > With this [..]
> 
> I forgot to actually attach that "this". Here it is. For real, this time.

Thanks.  Do you think your one-liner remains desirable with this fix in
place?
