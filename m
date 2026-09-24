Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E43A5E87;
	Thu, 24 Sep 2026 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242501; cv=none; b=QRjvwtFs0NJgi/eN/aLu40VYdr8iafbbh4jAl5cMXqiYT0QWFMC+WzIcfohm+gxYGUi30bXoL9AiTqKeXC8lWVbg0lH9gqXVsWkRMMpB1+lwvgqiGd9ej2pvq9T+A8c4IZyNvdljugIHHFscOzm+ZnGSy2mTcdPdpusgcxK9LxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242501; c=relaxed/simple;
	bh=IuX8jTTYJ8NyywhPtLRRV9sA1F7vf30GeNtA2COnEFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4EWo0Isc9nHKaxoGo6t3cO/ItyQlkkq1UnrAvfMArwLSl2mjgr3mIs4Pe4Vvrkn87/tx+4gb+p6Oc/KdN7+8VrAboWxASZfdWEZbpwb2nbAJvxuRhjNeUVa+pYFw7Epg22aapAtg3f9O4WFLADfIqNaoTu8iJnU++8mC3dxd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mUvZLLvq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUvZLLvq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NRGkWUe9619LvbBMEXcxaKtHAE3240PhPtEdXzFuBI0=; b=mUvZLLvqEJm2rhbWzt318A8xLn
	/F3bVNp4g/z1Dvo0f910YshdypY5yFoPkqAxpSxVQ9viIZ+at04qidhPVnvPrrvCOoVTfC2+eAc1i
	tIOFODo6WILfQjr11vsu/1g+rfxnfiNekeA+vjlt6uS+o2gXUg/Nt5kyLNLymsQFrFVBPKvrs069D
	9vvu8aoG6W01JroueOFjYxUEHUiwg1VUg2Fd/1JSQDEZuF4jetwlVa7H6/phFjWDxO+s3ZkfQzlsb
	s/uDURDQm2bQYk0F35LlW7nw7dpuUU9CSavw6yuyaYVCs6TgYXUhgftO96RAdT956YWysP1F+Q0xF
	h91qRW5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9fqt-0000000FnDU-13e2;
	Thu, 24 Sep 2026 09:34:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 868D13006DD; Thu, 24 Sep 2026 11:34:50 +0200 (CEST)
Date: Thu, 24 Sep 2026 11:34:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, pierrick.bouvier@oss.qualcomm.com,
	paulmck@kernel.org, sid.manning@oss.qualcomm.com,
	linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2] smp: align struct __call_single_node to 8 bytes
Message-ID: <20260924093450.GN2009045@noisy.programming.kicks-ass.net>
References: <20260923154307.3625611-1-brian.cain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923154307.3625611-1-brian.cain@oss.qualcomm.com>

On Wed, Sep 23, 2026 at 08:43:07AM -0700, Brian Cain wrote:
> Consumers walking call_single_queue cast each node to call_single_data_t
> and, given that type's declared over-alignment, the compiler may load
> llist.next and u_flags as one naturally aligned double word.  Fields using
> this type, such as task_struct::wake_entry only guarantee pointer alignment,
> which faults on strict-alignment 32-bit architectures like hexagon.

Where exactly does this happen? I'm failing with grep.
