Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF62EB0F;
	Tue, 10 Mar 2026 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104426; cv=none; b=XNBEt3nOmrUnjBx+j8/6eGsmHzQdRXdYMw0/GtX8sPDZOvjAG0xLKT2vx1XQQ+2xLTfdHLWJ1F36q4dZus/eiMKA+jIWF7rPrwSB4Tzs045esR+m5B1zr3OOnGTX4ZvGL51NIZvYrMamShRRO/V1TYE0fG+0qF8y+H03DRdhPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104426; c=relaxed/simple;
	bh=ucmT4p18l1zVyxUUw0lvEnyqpW0i4kJiK96ub5xOeh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1DkeayA4ihDHUZkiXJsV1P+ycMcfZ1nxtNLgo7tc76cFdza5IGsR2yGpbBpOz0KkYpTMMSFDd0O5i653jInwyPjUVZ/sHNAdjnNCmHJjo6Wbgx8yl66+evgObpst0Qs3NSBzfBT2Jvwq2i5wC4lAkclu+wWhngWmZMbMW/AB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzZAMYEC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzZAMYEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84239C4CEF7;
	Tue, 10 Mar 2026 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104426;
	bh=ucmT4p18l1zVyxUUw0lvEnyqpW0i4kJiK96ub5xOeh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzZAMYECpe7/AQfu8jlRUAnEuPUdpRs0AU+nGE3O6LBPG+Ia5wMiuNIoppPrcY9Gf
	 JaGSQ6PjNwpheYbAvPCtiK+lS4Hgp2i3SJ8eE8Z5A2xtE2tvM2iyQmF9yXs7NRn4Fa
	 /g7itB4Ht8f+7NTS6Ns3DqG659VxYsA/HiapXCyuCdY6pLLiMRFVbG78sDw2N90NQo
	 wVq30CArRN4BbsVHtXNiKxyYji1gmTozq9vYVbv8T546MQePHfzTJNVO5qvNrPfpzE
	 V6VBeMw4loaHiGk4Q/9S68f9mKDCQTwIPCFd7vyARjYdVpSud4YHyJbqgeYA2yl0yu
	 8CIXrH9kVSl6A==
Date: Mon, 9 Mar 2026 18:00:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nicolas Schier <nsc@kernel.org>, Brian Cain <bcain@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 0/9] kbuild: uapi: remove usage of toolchain headers
Message-ID: <20260310010021.GA1321389@ax162>
References: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227-kbuild-uapi-libc-v1-0-c17de0d19776@weissschuh.net>

On Fri, Feb 27, 2026 at 07:37:58AM +0100, Thomas Weiﬂschuh wrote:
> Currently the test compilation of some UAPI headers requires a toolchain
> libc headers. Remove that dependency.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Thomas Weiﬂschuh (9):
>       hexagon: uapi: Fix structure alignment attribute
>       kbuild: uapi: test linux/bpf_perf_event.h on powerpc
>       kbuild: uapi: deduplicate linux/bpf_perf_event.h exclusions
>       kbuild: uapi: completely exclude linux/bpf_perf_event.h on nios2
>       kbuild: uapi: only use dummy-include for headers which use libc
>       kbuild: uapi: provide stub includes for some libc headers
>       kbuild: uapi: use custom stub headers instead of libc ones
>       kbuild: uapi: simplify libc dependency logic
>       kbuild: uapi: remove now unneeded guard headers

This is nice! For the series:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
