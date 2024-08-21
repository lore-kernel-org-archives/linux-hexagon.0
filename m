Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECA33C5;
	Wed, 21 Aug 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724203119; cv=none; b=M8H6L4so2LZQWxtnk2kUoo/+jQbZ77KO7GzE1RMM9MFSCt6KRInACl/JjZc4xYkAUeKc1Atzt0jGN7mInCVMcQJEi797qCQv876bwBaOq5iudrGDuYh8p5Z7Acy9yBr+3EaZisZ1m7yP/pOHNegWkaNemYaO/1K38ST9QY4F2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724203119; c=relaxed/simple;
	bh=bqLgu5rCY6FwxrHMn3oG9AZSGc/vl8klIaH3jFWN1QY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RFZA5Nmk9qnKlmDTHBZG2foAI0weno7lBoEpscs+REL159kY8kloy58f20l0d9Q17nHNb1cIQi2dWj1b9uR4IfvEy311Hb5vTJpRnD9wnWhxB2NXwi+p9DozD2Eup13doj8M6PsnnUjxtlAcS++b01I6fPI1DK/NVhl2pvquxf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J7HW4rBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J7HW4rBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2772C4AF1C;
	Wed, 21 Aug 2024 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724203118;
	bh=bqLgu5rCY6FwxrHMn3oG9AZSGc/vl8klIaH3jFWN1QY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7HW4rBxhF/HrPEjaCJdLiVU49cBPm7VSaD9bLo71rgfjuow5pC1T829ekAR5qhbt
	 y0AJp1Dye1XHvNgijTcPSn/K+3aFMY0KrpEYB4Jf2LPy+9du5uUB+wosLhZdsiMS2H
	 3sOrZ4VDg694Av7PSihHm8BXGsBxnjelk958OsxQ=
Date: Tue, 20 Aug 2024 18:18:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rob Landley <rob@landley.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian
 Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
 jeffxu@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com,
 linux-um@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon
 <linux-hexagon@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-Id: <20240820181837.4d470b8837db618827b7bef7@linux-foundation.org>
In-Reply-To: <CAHk-=whvR+z=0=0gzgdfUiK70JTa-=+9vxD-4T=3BagXR6dciA@mail.gmail.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
	<20240819195120.GA1113263@thelio-3990X>
	<CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
	<CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
	<87y14rso9o.fsf@mail.lhotse>
	<CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
	<dff57198-7955-ec09-8909-671982834673@landley.net>
	<CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
	<67108df9-7374-a64e-ca82-8c46d67fb55b@landley.net>
	<CAHk-=whvR+z=0=0gzgdfUiK70JTa-=+9vxD-4T=3BagXR6dciA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 16:14:29 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Andrew - I think this is good, but there may be other issues lurking.
> Do with it as you see fit,

Hey you know me, I'll merge any old thing if I think it'll help nurture
newbies.
