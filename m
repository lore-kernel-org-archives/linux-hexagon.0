Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5A2576;
	Sat,  1 Feb 2025 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738383495; cv=none; b=gCWLXd6Rf+uw8TqkYuzRSROfoDrSfr+ZyWxxtmnSna3c8HJKISQoYaMjMvgZeviIoNy9Yv8JyNIpDuxBCBFfvh2FaxgtjzWYY4hXY4VUz5d0aLTc3VMUnBhB85EbuKUkt4iHpkFQpeIRlm6CjC9e6/pkuF+JzfOLjdGdicBM7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738383495; c=relaxed/simple;
	bh=sZyKWVfNAEcXgG8ck6oZHxhOhJZmRyPyRZjmhRSvPFs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Nbo25zFJBz6vvnQpGtcrE8Q0z+ylXbSew1NQ5B8qqo3/8Hj7KmQmca/zTQBja6ZTx8fOnTCul1NPLmZmHb9v/fbfS+5pjfzzoIuiz4ZN+EZIXdfOolixxFec98IguExgl5SpzxfKxXCbWVBfPWGE3bt4e0G0ziHnMP8Vo+IBQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by5K6UDU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by5K6UDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C99C4CED3;
	Sat,  1 Feb 2025 04:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738383494;
	bh=sZyKWVfNAEcXgG8ck6oZHxhOhJZmRyPyRZjmhRSvPFs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=by5K6UDUr3x4d4DS7nls9yRRxLYp31Y6QzxorM1+LcBPX02xUmF5q6oubtnDQUM/1
	 B5F9UwxaGsOVg3DzoG9i8O7kKB2QldGUiu7QbRIawezIy6vNPMPjE1NeG4Y7pwvvjN
	 iiUMi3Cv69N9NsQfg5ulJovVWflLvZDJcV/cS8lGmvXc4tJlqpphkFZ+uk+5WlOIcJ
	 QrRms3zJHywUrQMJyr97koegpbDxtvU/phtd5zYAxcenhp6oioBox5JVyzQLKcJq5d
	 64JxgG/1lIa92JtkYa6oYWtshKCciqVUA4ZWQKGhvJeRsjW7v8buEXpJriDPaZvVqx
	 11u21R4v65VCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34ACA380AA7D;
	Sat,  1 Feb 2025 04:18:42 +0000 (UTC)
Subject: Re: [GIT PULL] hexagon changes for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <971d297c-cc66-4947-9bf7-33aa7fc12673@oss.qualcomm.com>
References: <971d297c-cc66-4947-9bf7-33aa7fc12673@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-hexagon.vger.kernel.org>
X-PR-Tracked-Message-Id: <971d297c-cc66-4947-9bf7-33aa7fc12673@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace refs/heads/master
X-PR-Tracked-Commit-Id: 84d78214b4f187da7e029f5dad344203511a04d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60c828cf80c07394762a1edfaff63bea55cc8e45
Message-Id: <173838352064.1817114.12338537718880934740.pr-tracker-bot@kernel.org>
Date: Sat, 01 Feb 2025 04:18:40 +0000
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hexagon <linux-hexagon@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "sidneym@quicinc.com" <sidneym@quicinc.com>, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>, "quic_mliebel@quicinc.com" <quic_mliebel@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jan 2025 21:27:18 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60c828cf80c07394762a1edfaff63bea55cc8e45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
