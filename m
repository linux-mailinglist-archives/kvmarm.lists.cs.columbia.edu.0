Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9E195D20
	for <lists+kvmarm@lfdr.de>; Fri, 27 Mar 2020 18:48:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C868B4B092;
	Fri, 27 Mar 2020 13:48:48 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QLHo27gy7hqA; Fri, 27 Mar 2020 13:48:48 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B5DD94B087;
	Fri, 27 Mar 2020 13:48:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 53E9F4B087
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Mar 2020 13:48:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DmX1XJ3f0W04 for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 Mar 2020 13:48:45 -0400 (EDT)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 45FB14AEDC
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Mar 2020 13:48:45 -0400 (EDT)
Received: by mail-wm1-f67.google.com with SMTP id g62so13342580wme.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 Mar 2020 10:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ahItD5ciKQlH35hkuZa9rsjTTheAXpNOZVWcDd0E20Y=;
 b=Nhep4Mv0Ct5wh4tYFff+xDjvhfee2zYaRMnPgSPjcib1z6wOJALzhhNrSp7vtOSzim
 /50aB9L7BEsDjtBO6dCXY50uEsqW9IZGMoyu0t+TJ3yZyz38Yeh5mfOruWQW3MSn6luC
 Cak3tRDx1n5xrS4Gi0PyJpLugknQEBeGaHr5jmJxLJknJJw5T0TfSb5ZrXHV4kHqWawj
 q40zxiOcKCG+tcrmmuwiPVmb4yZNZtGh6pDowziZfZ8cfFrzoqW1Yqg8f+Y+QfYl7nn0
 dcbsAzGu6wVFHdWHjCjsrInt/OqECzACb2Mp12aGBHO8yaaLjIHdr4ZESrP22powmxB8
 74UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ahItD5ciKQlH35hkuZa9rsjTTheAXpNOZVWcDd0E20Y=;
 b=A/+uJVT01P6jmYtN/D3h9bSYBuMrOKccOQ7nYfe2g8dCEbHMmJw9f99BYZ+7Gkqu6+
 3/uUb7IQytB9NuqsgzAUBeEB84tKFhEJ4ZXJDSsuiE9pdYRRPBw9d8S50WHO4zFKuUhD
 4s9XiXCa23EqaSQLLWg1Q/sYt4Bex3juhsiBGHdG3TSk9caqEtejW5q4gooxFrCcI5CH
 X9Yy001t3acBtjBfFZC95v0HqFF84AgZM2k52L6sUoQczuS739HQZsADjqw/XM4JKz1i
 gS+5Ma0vuk0TrzekDf7FfZcEkhOGCqD7V3D49NImOfw1TV5wz8MPXKqhkkFyzSi04SgK
 CMmQ==
X-Gm-Message-State: ANhLgQ2p6bWuZ4PIBgyWHbKJBAGKeSgrIgl9pCTmEIHM+fj1gbMGJbjr
 Z4cPj/DlmCpr7MoEF8VdnrGz8w==
X-Google-Smtp-Source: ADFU+vuj6jzPUh/Z88x9sm8cEUTuPhAXo/pdaIEKP0x+19gSf3BxmtaPc3dTBP0v3lRurwkOFeOKKg==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr6493410wms.18.1585331323915; 
 Fri, 27 Mar 2020 10:48:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:109:355c:447d:ad3d:ac5c])
 by smtp.gmail.com with ESMTPSA id p10sm9508117wrm.6.2020.03.27.10.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 10:48:43 -0700 (PDT)
Date: Fri, 27 Mar 2020 17:48:38 +0000
From: Andrew Scull <ascull@google.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [RFC PATCH] arm64: unify WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}
Message-ID: <20200327174838.GD178422@google.com>
References: <20200327143941.195626-1-ascull@google.com>
 <1705907b-234c-6f56-1360-f598c8047d1d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1705907b-234c-6f56-1360-f598c8047d1d@arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: "qwandor@google.com" <qwandor@google.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, "wedsonaf@google.com" <wedsonaf@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "dbrazdil@google.com" <dbrazdil@google.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "tabba@google.com" <tabba@google.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Thanks, Steven. Could we look into the EPD* caching microarch details
Marc was referring to for these A55 and A76 cores?

If the behaviour is the same as A57/A72 then it sounds safe. Otherwise,
there'll need to be some invalidation to avoid that issue.

And thanks for the pointer to your previous patch, it's a very helpful
reference.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
