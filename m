Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5064069F
	for <lists+kvmarm@lfdr.de>; Fri,  2 Dec 2022 13:19:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DF27A4B3C1;
	Fri,  2 Dec 2022 07:18:59 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@intel.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EjNHqxACSAVp; Fri,  2 Dec 2022 07:18:59 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4D1304B1B7;
	Fri,  2 Dec 2022 07:18:58 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 939604089A
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Dec 2022 07:18:57 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYLMswdu7AI0 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  2 Dec 2022 07:18:55 -0500 (EST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8CDE54052C
 for <kvmarm@lists.cs.columbia.edu>; Fri,  2 Dec 2022 07:18:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669983535; x=1701519535;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wi48IRAlj8rws7OXian+RqCB7j1U88ZDa1zqvDwWk3c=;
 b=efxfcj8ENLTl62HabsxPfwYVGRFdWPDcoKp8qhazkyrMOt38mK+a9HJu
 8NwQPC3b4flsg8BF9phh6dLgqAxtK94tpPdzNT6Ue3QaA+9GKXW5SulH+
 U/YilEU1S8o0uPetVJ+yxtgFlnOnmWayBtH7x1e92TPvPDOvqmYlXpNcn
 oS8yBgVDIvEKdlrJ8F0M/zC53k/YqnHSajc9YiDqxyh2CksqJIJiLW2vG
 4uZEjpD/5jF/c3LUSclQrPjdD+YD0cViYXvvPX1Q9VkLV1KEGuDuBF98O
 xYn9n5naKm0e9KqxUkierM+dg3Ae3CjTuGbPqBn6Pmdh1zFzzNzhrWA4V g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303544309"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; d="scan'208";a="303544309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2022 04:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="677582600"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; d="scan'208";a="677582600"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP; 02 Dec 2022 04:18:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 04:18:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 04:18:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 04:18:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 04:18:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+YVQYh8kEpkh1kwsXNoCo2I+ywl9up8yv8Jbv6b/8wuo4rx1p41rPs/n2F0iEoQLrpBQqtWp0XpaX9MGT6+1Nti/kgnBlGYftUtmGq2PdXDSD/KCpN4vkhxIlAIWb4m6RSq5PUzGkBnY9GWox6cP+wjdHeLkRwQndpwVEwmMA56Jw+7BNYzcTCa8NYI9JU24aAdvAsltSwSpGWVM6ZRJ1GmZf9CBjGOpGXZLIbVzCHl+REbemh9IyyJlZdwZ96aazHVhN/uwlGCNgrjRlmbDoAhQOMAUX0en2nKUpgYgqfB5gYBnN7+WX9QzkKH3rD5IpVWLpmAxpFLOkAT66wKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi48IRAlj8rws7OXian+RqCB7j1U88ZDa1zqvDwWk3c=;
 b=MxoZ8LXqL2ypwySuP2agnbFi4afD5w3N6PVYoCepM3SrNGxbWnRqEGLTQsMD/5jBDa/6xOsPUs/Mp4xJyYt1PGqxnFGvaO9PMifUhfS7d+rJ9+znXaMCnwrgfNQ9had4fnM+5B+CBkkAfIs2U3VIGsh4HwtEpfLEbWcNojgtC0MWb5pyTX3L9Kvh98Fgt9TjAMUtGCW3KVS1fHbmiAkWO90BDalZ5Hw/Cf+0rm55nWxAxdk+mSIjBNF1LXMYrI9dHlKHvT1OznWIIXRnK5cdg3mGBPShgIO1w/dmtAtKq842t9a5//KR2WgyeNfGQtp91kTHVigHzKc60HOk2rxppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 12:18:49 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 12:18:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "maz@kernel.org"
 <maz@kernel.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "Christopherson,, Sean" <seanjc@google.com>, "paul.walmsley@sifive.com"
 <paul.walmsley@sifive.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
 "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>, "paul@xen.org"
 <paul@xen.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "anup@brainfault.org"
 <anup@brainfault.org>
Subject: Re: [PATCH v2 35/50] KVM: VMX: Use current CPU's info to perform
 "disabled by BIOS?" checks
Thread-Topic: [PATCH v2 35/50] KVM: VMX: Use current CPU's info to perform
 "disabled by BIOS?" checks
Thread-Index: AQHZBRD6iqD9Xi/jQ0CDB6+2sIzlZa5ahlMA
Date: Fri, 2 Dec 2022 12:18:49 +0000
Message-ID: <94ced947d0f6a82905afbfe413cf1b6d16fa5fd8.camel@intel.com>
References: <20221130230934.1014142-1-seanjc@google.com>
 <20221130230934.1014142-36-seanjc@google.com>
In-Reply-To: <20221130230934.1014142-36-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5061:EE_
x-ms-office365-filtering-correlation-id: 62133e92-ac4f-42f0-c652-08dad45f5e2c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxrWgTc450VZbeWbFPvWZQCwS+1pjY08Xt4utqXgK+ImRNq8FpaEOu3OQcjYVZFwUG1be1U5GWwE0GczDYmqjmh1e5HSotKJ+zb0UxjSQxGru+cXtXVZNVabTjccQWvu2kMgZnwyLyfgv1MJkvom/XCE4RypXujnLSDJuOC0UGbNy8lEvrEUlYX2CRIys3LqinyaDTdWJxAPUMEE4QIlVyeE7hjGhB/uZM2ydsjZQOzwkXtWaWFnNiJyoyg+QfQntFbbGMSNZOWRQ4GwQ7rseqTKCM+Q26SK3BDdWgxJVGtHHw5LrwEVdQCG56/PLgQ4pvz6hnJ997bOMwR2YRoZ8VCvMtnywPnS+Dwc1xSSDo9c33VBldOMB7uGxYfT7RqvhMZPliLGVEhDccVtrJk7MP258zIogadjAWtJCB7clPNoNVlPahJtMpMv2OA7qLH7HRibiQnj0reaWB6dNhTfh7EJe+fsUjEW3dPWLlJ082zh456bm2bTCCarQo+H6r9p6YU6gmewFDQCGd2UnrPr1hAAZ9eqbIQzfscojXOiAYemEoUcDfcpkSiE52WgSF101IIhz61+NgACku7Ho1DFC8bvWY0N9AhPyCO6Jd7G6eCis4U3Q0JmEpCYMnoYANWT28OHQUS/J/CTUtWQarfhUciQnlnoGJpgviQ/vdIRiaKzrZtoGp3PU0mz7E3tSUNm7T97LcynK7vVT4TSJbzbDQamHW5IGddVn2z36tp2q2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5978.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(2616005)(110136005)(6486002)(316002)(38070700005)(54906003)(36756003)(921005)(86362001)(107886003)(82960400001)(38100700002)(6506007)(83380400001)(186003)(26005)(122000001)(6512007)(7406005)(4001150100001)(478600001)(2906002)(64756008)(66556008)(66476007)(41300700001)(5660300002)(71200400001)(8936002)(66946007)(76116006)(66446008)(91956017)(7416002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXpjSks2T2ZVTitRMDJVM05wRUJ3c1p3dUllSzRjWDFWTW1TVFNtWHp6QThF?=
 =?utf-8?B?S2hTMjNuWUdBdVhJS0tPQTdwdzBaQndoSjFqZDFVOGNCeGcwK2p5NUhueE4x?=
 =?utf-8?B?eVRyZVFtdjZoN3ZoMXFDVlNQMEFIdnh5UW10bzgvSGFISkZVTlIwYmF5ZXl6?=
 =?utf-8?B?bm5SZkJxZHBjcUFJMWRHNldTY05QYlpKOGcyaEZtQW50YlcyTDBQdjR3RjY4?=
 =?utf-8?B?N0lmRjROZXNZUGtTcHUxT3p1QThCclp1N3loSnhzTDUyS29jTGZoL0lNNzhr?=
 =?utf-8?B?WGduUFZRVm9KN2pXZW5qcnM0SXArUE5NS0tlU0EybERwajhHQUREUk55ZHM4?=
 =?utf-8?B?ZkxJRHpmTnZ4b3Z2MGtWYllTcTdaQ1FpTE1KRGJjRmdROGhtekxvQWJEMS9V?=
 =?utf-8?B?NzNpV041WGRXd3FZeDVIeHNpcG5yYWNDRjluNXM4UkZVRkpTNkV5TTFUeERm?=
 =?utf-8?B?THRGcDBvVzVjaS95K1MrY2VEK1U4bm9pVUROUlFkcUMyM3U4MWppa3hpZUZZ?=
 =?utf-8?B?NUsydzQ2TkZRVC9TV1FJWE9TWjJBc0JGSTZxZlRIZHJSRUNkMnBwT2Q4b2tB?=
 =?utf-8?B?a0g1UXNzRUNONG0rZFFQTkkzbHNzWG8zUTI0dE15YjJVc0M1VG9TaEZnU3RE?=
 =?utf-8?B?N1ZjUzB0aXN0Z3JoRjMvd1RJR1FwOXZROXMvbHRsdzNPY2dQUXRPNmNpa3o1?=
 =?utf-8?B?YUowSnVGaFVzNVJxemdjeEdhUFVTZ3o1UVNGVDFaQXlVREpvYmw0M3k0R3ZY?=
 =?utf-8?B?aVp3YWh1MkFsYTZOc1BHaGtSMmdmVFU5aTFhVURuWEx6U215VVZDVk8yeW9E?=
 =?utf-8?B?YVBBaEdLcnZwQXhMUHFhcmgwZHhxUG4zMWZYcGFzZkN1amQ4bXFGYkV2RXVz?=
 =?utf-8?B?UG9vZkpPRDVia0ExK0FaOWJRdUN6OUNxTmxWVnhUZHNBSUw1MXVHMXBNL203?=
 =?utf-8?B?Zjc5ZXpCOXFBTTQxKzZsWVBndWVQWldnUGE5YUpxRzF4Rkk0RzlCTDlYTXh1?=
 =?utf-8?B?ODhWSEhHS21MOHhuTU9YYklEMkcwNmtDazJGam5lUjlTcTdJQ0xlTFpTZitS?=
 =?utf-8?B?RStpL052bEIwdkxpMVQ4Y0dJa05pMmtRTEZ1N2EwbVozOVlxcnR2empCTlpm?=
 =?utf-8?B?MmNEYmtMRHVXR3p5aklRWlhOOG9Bdk55Qmp2UnFzVDhDS2FqRmVTd295SWhi?=
 =?utf-8?B?SUM1Wldoa3VxUHRwS0poT0VYS3k5OStTdnNQdVYxdEx1R1puSGk2dFdDODlF?=
 =?utf-8?B?RnJxZmxTaW9kVlQ3MWRTNXhxVVJGNDV0OTJGczJsM0xaeDkxUnJWbG1uclR3?=
 =?utf-8?B?TmhRNzFJVFpPd1lKNld5SFFGeEtmaGZtNFlKSGRXZURvcWZ4RFIzZmZITFo1?=
 =?utf-8?B?YUpkb1EzVzVoSk9rTjQ2VHdSTUZHSSt6YlY2SDFoNlJ4VzFxWFZ0ZTFUbUxM?=
 =?utf-8?B?MWlrVzhtYXpzQy9EV05xWjBDenlaYk81aHgzQzN5emxnMTBiYTdiNGRYNFVW?=
 =?utf-8?B?cTUycFRHbFdtaFphbzRETHBlUWxwSnVPZ3h6U3loYzhPL05PTVdMRnhPUUpp?=
 =?utf-8?B?MkFSVmpXbGd3emNVb3BxajVhVFRDdWJiM0h5ckx1ejFRY0VObko0VnlIdjZL?=
 =?utf-8?B?RlZkUmd3TURwckV5Y2N0UWRpWGlPZXZDY2tJQ2h5c0Z5UFBmZ0tMWHNMWWFH?=
 =?utf-8?B?MG9mMmtjRys5MWdTYlNLbm0zaXRMRXhaSXUreHhXcjJEWXBEZWRGdEx0SmU4?=
 =?utf-8?B?M3FyUTJSOC9EUFIwanhjYkNGdExWeURWNG5hN0o0OGNYWldIc1drMDdpSUZQ?=
 =?utf-8?B?YXVvQmFoRm1WQWJVdGVSWUlIS0tUbUJQQWU5MHZ1YkhMSHN2U3M2OE9yd2ov?=
 =?utf-8?B?SExLNmxDUG1XM25NSUEyNnBCZmtZQnY4WlI5emlwZUdwSHlsMVEwU1lHemx1?=
 =?utf-8?B?RUJobVErcFVSckNsWnlXTWlSRFVBSWxoMTRaN0lWU2RDcFFJd1RzdkIvN2Fo?=
 =?utf-8?B?NzZpMEpUUW1UL3U0VDltamFGdjlFOGhVcjd6NzVqN2ozeFFWT3BuLzRSdit4?=
 =?utf-8?B?Tjhzb0FDS3Znajd5bzd1VHlPck5GTVlJZTBSelAxeVdjemVDSUJDVzBmYXhZ?=
 =?utf-8?B?cEZ4UTdXK01ONEwzQmFtUFdPY1dqb1R6NjNCYU5zRjZQR1N3bW03dEEybkxL?=
 =?utf-8?B?d0E9PQ==?=
Content-ID: <99D4C9A3D984C2428A927ED5B867F5BF@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62133e92-ac4f-42f0-c652-08dad45f5e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 12:18:49.2695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8sfVH2lNpgmmjNH3fhelMv0ILsRAGM5Re0l7ofIu3xuYV3WnXzg8Lp2u42wHkephYXX5NDKJAnScO8VqLpPzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "david@redhat.com" <david@redhat.com>, "Yao, Yuan" <yuan.yao@intel.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "Gao, 
 Chao" <chao.gao@intel.com>, "atishp@atishpatra.org" <atishp@atishpatra.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "farosas@linux.ibm.com" <farosas@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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

On Wed, 2022-11-30 at 23:09 +0000, Sean Christopherson wrote:
> Use this_cpu_has() instead of boot_cpu_has() to perform the effective
> "disabled by BIOS?" checks for VMX.  This will allow consolidating code
> between vmx_disabled_by_bios() and vmx_check_processor_compat().
> 
> Checking the boot CPU isn't a strict requirement as any divergence in VMX
> enabling between the boot CPU and other CPUs will result in KVM refusing
> to load thanks to the aforementioned vmx_check_processor_compat().
> 
> Furthermore, using the boot CPU was an unintentional change introduced by
> commit a4d0b2fdbcf7 ("KVM: VMX: Use VMX feature flag to query BIOS
> enabling").  Prior to using the feature flags, KVM checked the raw MSR
> value from the current CPU.
> 
> Reported-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Kai Huang <kai.huang@intel.com>

> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e859d2b7daa4..3f7d9f88b314 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2492,8 +2492,8 @@ static __init int cpu_has_kvm_support(void)
>  
>  static __init int vmx_disabled_by_bios(void)
>  {
> -	return !boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
> -	       !boot_cpu_has(X86_FEATURE_VMX);
> +	return !this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
> +	       !this_cpu_has(X86_FEATURE_VMX);
>  }
>  
>  static int kvm_cpu_vmxon(u64 vmxon_pointer)

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
